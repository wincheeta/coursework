public class Simulation {
    public static void main(String... args) {
        //simulateStudentAccess();
        //simulateDoorControl();
    }
    /**
     * Checking lock status of CardLock with student access.
     */
    public static void simulateStudentAccess() {
        System.out.println("--- Simulating Student Access ---");
        System.out.println();

        CardLock lock = new CardLock();
        SmartCard cardA = new SmartCard("Anna Undergrad");
        SmartCard cardB = new SmartCard("Dr. Bob Lecturer");
        cardB.setStaff(true);

        System.out.println("* Toggling the lock to allow both students and staff...");
        lock.toggleStudentAccess();
        System.out.println();

        System.out.println("* Swiping " + cardA.getOwner() + "'s card");
        lock.swipeCard(cardA);
        System.out.println("Is the card lock unlocked? " + lock.isUnlocked());
        System.out.println();

        System.out.println("* Swiping " + cardB.getOwner() + "'s card");
        lock.swipeCard(cardB);
        System.out.println("Is the card lock unlocked? " + lock.isUnlocked());
        System.out.println();

        System.out.println("* Toggling the lock to allow only staff...");
        lock.toggleStudentAccess();
        System.out.println();

        System.out.println("* Swiping " + cardA.getOwner() + "'s card");
        lock.swipeCard(cardA);
        System.out.println("Is the card lock unlocked? " + lock.isUnlocked());
        System.out.println();

        System.out.println("* Swiping " + cardB.getOwner() + "'s card");
        lock.swipeCard(cardB);
        System.out.println("Is the card lock unlocked? " + lock.isUnlocked());
        System.out.println();
    }
    /*
     * Simulating CardLock control of a Door.
     */
//    public static void simulateDoorControl() {
//        System.out.println("Simulating door control");
//        System.out.println("======");
//        Door door = new Door();
//        SmartCard card = new SmartCard("john man");
//        CardLock lock = new CardLock();
//        door.setRoomName("Research Labs");
//        door.attachLock(lock);
//
//        lock.swipeCard(card);
//        door.openDoor();
//        card.setStaff(true);
//        lock.swipeCard(card);
//        door.openDoor();
//    }
}

