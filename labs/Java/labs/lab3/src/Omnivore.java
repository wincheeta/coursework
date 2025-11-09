public abstract class Omnivore extends Animal{

    public Omnivore(String name, int age) {
        super(name,age);
    }

    public void eat(Food f) {
            System.out.println(f.getName() + " eaten");
    }
}
