public class Wolf extends Carnivore {
    public Wolf(String name,int age) {
        super(name,age);
    }

    public void makeNoise() {
        System.out.println("Wolf makes noise");
    }

    public void eat(Food f) {
        super.eat(f);
    }
}

