class CardLock{
    SmartCard lastCard;
    boolean locked;
    boolean studentAccess;
    public CardLock(){
        this.locked = true;
        this.studentAccess = false;
    }
    public void swipeCard (SmartCard card){
        this.lastCard = card;
    }

    public SmartCard getLastCardSeen(){
        return this.lastCard;
    }

    public void setLocked(){
        if (!this.studentAccess) {
            if (this.getLastCardSeen().isStaff()) {

                this.locked = false;
            } else {
                System.out.println(this.getLastCardSeen().isStaff());
                this.locked = true;
            }
        }else{
            this.locked = false;}
    }

    public boolean isUnlocked(){
        this.setLocked();
        return !this.locked;
    }

    public void toggleStudentAccess(){
        this.studentAccess = !this.studentAccess;}

}
