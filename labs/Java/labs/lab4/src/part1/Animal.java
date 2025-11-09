public abstract class Animal implements Comparable<Animal>{
    private String name;
    private int age;

    Animal(String name, int age) {
        this.name = name;
        this.age = age;
    }

    Animal() {
        this("newborn", 0);
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }
    public abstract void makeNoise();
    public void eat(Food f) {

    }
    public void eat(Food f, int i) {
        for (int j = 0; j<i; j++) {
            this.eat(f);
        }
    }

    public int compareTO(Animal a){
        if (this.getAge() > a.getAge()) return 1;
        else if (this.getAge() < a.getAge()) return -1;
        else return 0;
    }
}
