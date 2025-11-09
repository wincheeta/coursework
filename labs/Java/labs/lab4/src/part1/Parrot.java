public class Parrot extends Omnivore {

    public Parrot(String name,int age) {
        super(name,age);
    }
    public Parrot(int age) {
        this("Polly",age);
    }
    public Parrot(){
        super();
    }

    public void makeNoise() {
        System.out.println("Parrot makes noise");
    }

    @Override
    public int compareTo(Animal a) {
        if (this.getAge() > a.getAge()) return 1;
        else if (this.getAge() < a.getAge()) return -1;
        else return 0;
    }
}
