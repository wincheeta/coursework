double find_average(const double array[/* length */], unsigned length)
{
  if (length){
    float average = 0;
    for (unsigned i = 0; i <= length; i++){
      average += array[i];
    }
    return average / length;
  }
  else{
    return 0;
  }
}

int main(){
    
    return 0
}