public class Wolf extends Carnivore {
    public Wolf(String name,int age) {
        super(name,age);
    }
    public Wolf(){
        super();
    }

    public void makeNoise() {
        System.out.println("Wolf makes noise");
    }

    public void eat(Food f) {
        super.eat(f);
    }

    public int compareTo(Animal a) {
        if (this.getAge() > a.getAge()) return 1;
        else if (this.getAge() < a.getAge()) return -1;
        else return 0;
    }
}

