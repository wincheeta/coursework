public class new_Main {
    public static void main(String[] args) {
        Wolf wolf = new Wolf("john",12 );
        Parrot parrot = new Parrot("jogn",1);

        wolf.makeNoise();
        parrot.makeNoise();

        wolf.eat(new Plant("Carrot"));

    }
}
