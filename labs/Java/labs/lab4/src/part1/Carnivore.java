public abstract class Carnivore extends Animal {
    public Carnivore(String name, int age) {
        super(name,age);
    }

    public Carnivore() {
        super();
    }

    public void eat(Food f) {
        if (f instanceof Meat) {
            System.out.println(f.getName() + " eaten");
        } else {throw new RuntimeException ("Carnivore can only eat Meat.") ;}
    }
}
