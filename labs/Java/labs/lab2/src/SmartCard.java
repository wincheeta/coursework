class SmartCard{
    private String name;
    private boolean staff;

    public SmartCard(String name){
        this.name = name;
        this.staff = false;
    }

    public String getOwner(){
        return this.name;
    }

    public boolean isStaff(){
        return this.staff;
    }

    public void setStaff(boolean staff){
        this.staff = staff;
    }

}
