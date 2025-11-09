public abstract class Herbivore extends Animal{

    public Herbivore(int age, String name) {
        super(name,age);
    }

    public void eat(Food f) {
        if (f instanceof Plant) {
            System.out.println(f.getName() + "eaten");
        } else{throw new RuntimeException (" Herbivore can only eat Plants.") ;}
    }
}
