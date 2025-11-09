import java.io.File;  // Import the File class
import java.io.FileNotFoundException;  // Import this class to handle errors
import java.util.ArrayList; // Import the Scanner class to read text files
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

class interpreter {
    public static void dfghjk(String[] args) {
        variable ex = new variable("fghjk");
        System.out.println(ex.get_val()); 
        ex.inc();
        System.out.println(ex.get_val()); 
        
    }
}

class paraser {

    private List<String> file;
    private Map<String, variable> variables;

    public void main(String[] args) {
    
        try {
          File myObj = new File("code.txt");
          Scanner myReader = new Scanner(myObj);
          this.file = new ArrayList<>();
          variables = new HashMap<String, variable>();          

          while (myReader.hasNextLine()) {
            file.add(myReader.nextLine());
          }
          myReader.close();
          System.out.println(file);


        } catch (FileNotFoundException e) {
          System.out.println("An error occurred.");
          e.printStackTrace();
        }
        for (int i =0; i<this.file.size(); i++){
            String line = this.file.get(i).substring(0, this.file.get(i).length() - 1);;
            String[] cond = line.split("[,\\.\\s]");
            switch(cond[0]) {
                case "clear":
                    String var_name = cond[1];
                    if (variables.containsKey(var_name)){
                        variables.get(cond[1]).clear();
                    }
                    else{
                        variables.put(var_name,new variable(var_name));
                        System.out.println(variables);
                    }
                    break;
                case "incr":
                    variables.get(cond[1]).inc();
                    System.out.println(i);
                    break;
                case "decr":
                    variables.get(cond[1]).dec();
                    break;
                case "while":
                    List<String> temp = new ArrayList<>();
                    while ( ! this.file.get(i).contains("end") && i<this.file.size()-1){
                        System.out.println(this.file.get(i));
                        temp.add(this.file.get(i));
                        i ++;
                        System.out.println(temp);

                    }

                    break;
                default:
                System.out.println(cond[0] + "this is yet to be inplimented ");
            }
        }
    }
}

    public void extract_while(String[] instr) {
        List<String> temp = new ArrayList<>();
        while ( ! instr.get(i).contains("end") && i<instr.size()-1){
            System.out.println(instr.get(i));
            temp.add(instr.get(i));
            i ++;
            System.out.println(temp);
        }
    }

class variable{
    public int value;
    public String name;

    public variable(String n){
        value = 0;
        name = n;
    }

    public void inc(){
        this.value ++;
    }

    public void dec(){
        this.value --;
    }

    public int get_val(){
        return this.value;
    }

    public void clear(){
        this.value = 0;
    }
}