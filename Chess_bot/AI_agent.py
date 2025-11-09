import random
import time
import sys
from extension.board_utils import list_legal_moves_for, take_notes, copy_piece_move
from extension.board_rules import get_result

# --- Constants ---

# Assigns a value to each piece for the evaluation function
PIECE_VALUES = {
    "pawn": 100,
    "knight": 320,
    "bishop": 330,
    "right": 700,  # This custom piece is very strong (Rook + Knight)
    "queen": 900,
    "king": 20000
}

# A score representing a checkmate. Added/subtracted by depth to prefer faster mates.
MATE_SCORE = 1_000_000

# Custom exception for cleanly handling timeouts
class TimeoutException(Exception):
    pass

# --- Main Agent Function ---

def agent(board, player, var):
    """"
    This is the main entry point for the agent. It sets up the iterative deepening
    search and returns the best move found within the time limit.

    Parameters
    ----------
    board: the current chess board
    player: your assigned player role (white or black)
    var:  [ply, THINKING_TIME_BUDGET] a list containing the ply ID and the thinking_time_budget (secs)

    Returns
    -------
    piece: your selected chess piece
    move_opt: your selected move of your selected chess piece
    """
    start_time = time.perf_counter()
    ply, time_limit = var[0], var[1]
    
    # Apply a safety buffer to the time limit to ensure we return *before* the hard cutoff
    time_limit_with_buffer = time_limit - 0.2 
    
    take_notes(f"\n--- Ply {ply} ({player.name}) | Time Limit: {time_limit_with_buffer:.2f}s ---")

    best_move = None
    try:
        # Call the iterative deepening search function
        best_move = find_best_move(board, player, start_time, time_limit_with_buffer)
        
    except Exception as e:
        take_notes(f"ERROR in agent: {e}")

    # --- Fallback Logic ---
    # If no move was found (e.g., timed out on depth 1 or an error occurred),
    # default to a random legal move to avoid an invalid move.
    if best_move:
        piece, move_opt = best_move
        take_notes(f"-> Best move: {piece.name} to {move_opt.position}")
        return piece, move_opt
    else:
        take_notes("-> No best move found, returning random move.")
        legal = list_legal_moves_for(board, player)
        if legal:
            return random.choice(legal)
        else:
            # This should only happen if the game is already over
            return None, None

# --- Iterative Deepening Driver ---

def find_best_move(board, player, start_time, time_limit):
    """
    Performs an iterative deepening search.
    It searches to depth 1, then depth 2, then depth 3, and so on,
    until the time limit is reached.
    """
    best_move_so_far = None
    depth = 1

    while True:
        time_left = time_limit - (time.perf_counter() - start_time)
        if time_left < 0.1:  # Not enough time for another, deeper search
            take_notes("-> Not enough time for next depth.")
            break
            
        take_notes(f"Searching Depth {depth}, Time Left: {time_left:.2f}s")
        
        try:
            # Start the alpha-beta search for the current depth
            score, move = alphaBeta(
                board.clone(),        # Work on a copy of the board
                player,               # The agent's player (for eval)
                depth,                # Current search depth
                -MATE_SCORE,          # Initial alpha
                MATE_SCORE,           # Initial beta
                start_time,           # The overall start time
                time_limit,           # The hard time limit
                best_move_so_far      # Pass the best move from the *last* iteration for move ordering
            )
            
            # If the search completes and returns a move (not a timeout)
            if move:
                best_move_so_far = move
                take_notes(f"  > Depth {depth} complete. Score: {score}")
            else:
                # This can happen if the first move searched resulted in a timeout
                take_notes(f"  > Depth {depth} timed out before finding a move.")
                break

        except TimeoutException:
            take_notes(f"  > Timeout at depth {depth}.")
            break  # Time is up, stop searching deeper
        except Exception as e:
            take_notes(f"  > Error at depth {depth}: {e}")
            break

        depth += 1  # Increase depth for the next iteration

    return best_move_so_far

# --- Alpha-Beta Search (NegaMax) ---

def alphaBeta(board, agent_player, depth, alpha, beta, start_time, time_limit, best_move_to_try_first=None):
    """
    This is the core recursive alpha-beta search function using the NegaMax framework.
    It returns a (score, move) tuple.
    """
    
    # --- 1. Check for Timeout ---
    # This is the most critical check and must be done first.
    if (time.perf_counter() - start_time) > time_limit:
        raise TimeoutException()

    # --- 2. Check for Terminal Node (Game Over) ---
    # Use the provided 'get_result' function to check for win/loss/draw
    result = is_terminal(board)
    if result is not None:
        score = eval_terminal(result, agent_player, depth)
        return score, None

    # --- 3. Check for Depth Limit ---
    # If we've reached the bottom of our search, return the static evaluation
    if depth == 0:
        score = eval(board, agent_player)
        return score, None

    # --- 4. Move Ordering ---
    # Get all legal moves for the *current* player on this board
    legal_moves = list_legal_moves_for(board, board.current_player)
    
    # If a best move from a previous iteration was provided, try it first.
    # This dramatically improves alpha-beta pruning effectiveness.
    if best_move_to_try_first:
        # We need to find the equivalent move in the current list
        for move_tuple in legal_moves:
            if move_tuple[0].name == best_move_to_try_first[0].name and \
               move_tuple[1].position == best_move_to_try_first[1].position:
                legal_moves.remove(move_tuple)
                legal_moves.insert(0, move_tuple)
                break

    # --- 5. Recursive Search (NegaMax) ---
    best_move_found = None
    max_score = -MATE_SCORE  # Start with the worst possible score

    for piece, move in legal_moves:
        # Create a new board state for this move
        cloned_board = board.clone()
        
        # We MUST find the equivalent piece/move on the *cloned* board
        # This is what copy_piece_move is for
        _, temp_piece, temp_move = copy_piece_move(cloned_board, piece, move)
        
        if not temp_move:
            continue  # Should not happen, but a good safety check

        cloned_board.make_move(temp_piece, temp_move)

        # Recursive call:
        # - 'depth - 1' as we go one level deeper
        # - '-beta', '-alpha' is the NegaMax swap
        # - The score is *negated* on return, as a good score for the
        #   opponent is a bad score for us.
        score, _ = alphaBeta(cloned_board, agent_player, depth - 1, -beta, -alpha, start_time, time_limit)
        score = -score
        
        # --- 6. Update Alpha/Beta ---
        if score > max_score:
            max_score = score
            best_move_found = (piece, move) # Store the original move

        if score > alpha:
            alpha = score

        if alpha >= beta:
            break  # Beta cutoff: This move is "too good" and the opponent
                   # would have avoided this line earlier. Stop searching.

    return (max_score, best_move_found)


# --- Helper Functions (Stubs Completed) ---

def is_terminal(board):
    """
    Checks if the game is over. Returns the result string or None.
    This is a wrapper for the function from board_rules.py.
    """
    return get_result(board)

def eval_terminal(result, agent_player, depth):
    """
    Returns the score for a terminal (game-over) node.
    We add/subtract depth to prefer faster mates.
    """
    if "loses" in result:
        # If the result string says our agent's color "loses"
        if agent_player.name in result:
            return -MATE_SCORE + (100 - depth) # Losing is bad, but a slower loss is "better"
        else:
            # The *other* player lost, so we won
            return MATE_SCORE - (100 - depth) # Winning is good, but a faster win is better
    else:
        # Must be a draw (Fivefold repetition, 2 kings, etc.)
        return 0

def eval(board, agent_player):
    """
    Calculates the static evaluation of the board from the
    perspective of the 'agent_player'.
    A positive score is good for the agent, negative is bad.
    """
    score = 0
    for piece in board.get_pieces():
        value = PIECE_VALUES.get(piece.name.lower(), 0)
        
        if piece.player == agent_player:
            score += value
        else:
            score -= value
            
    return score

def check_old_best():
    """Stub from the original file, not used in this NegaMax implementation."""
    pass