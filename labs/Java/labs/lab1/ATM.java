public class ATM {
    private Integer balance = 0;

    public static void main(String[] args) {
        ATM myATM = new ATM () ;
        myATM.go () ;
    }

    public void go () {
        int bal = -1;
        Toolbox myToolbox = new Toolbox();
        System.out.println("Welcome to online ATM banking");
        System.out.println("How much do you want in your account?");
        while (bal<0) {
            bal = myToolbox.readIntegerFromCmd();
            this.balance = bal;
        }
        System.out.println(bal);
        this.options();
    }

    public void options() {
        System.out.println("What do you want to do?");
        System.out.println("1 : Withdraw");
        System.out.println("2 : Deposit");
        System.out.println("3 : Inquire");
        System.out.println("4 : Quit");
        Toolbox myToolbox = new Toolbox();
        while (true) {
            int choice = myToolbox.readIntegerFromCmd();
            if (choice == 1) {
                this.withdraw();
            } else if (choice == 2) {
                this.deposit();
            } else if (choice == 3) {
                this.inquire();
            } else if (choice == 4) {
                this.quit();
            }else {
                System.out.println("Invalid option");
            }
        }
    }

    public void withdraw () {
        int remove = -1;
        System.out.println("                Withdrawal");
        System.out.println("How much would you like to withdraw?");
        Toolbox myToolbox = new Toolbox();
        while (remove<0 || remove>this.balance) {
            remove = myToolbox.readIntegerFromCmd();
        }
        this.balance -= remove;

        System.out.println("Your new balance is: " + this.balance);
    }

    public void deposit () {
        int remove = -1;
        System.out.println("How much would you like to deposit?");
        Toolbox myToolbox = new Toolbox();
        while (remove < 0) {
            remove = myToolbox.readIntegerFromCmd();
        }
        this.balance += remove;
        System.out.println("Your new balance is: " + this.balance);
    }
    public void inquire() {
        System.out.println(this.balance);
    }
    public void quit () {
        System.out.println("Goodbye");
        System.exit(0);
    }
}
