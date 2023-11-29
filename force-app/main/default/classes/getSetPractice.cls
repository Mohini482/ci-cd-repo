public class getSetPractice {
    public integer val{
        get{
            return val;
        }
        set
        {
            val=400;
        }
    }
    
    public decimal val1{
        set{
            val1 = value * 0.9;
         }
        get
        {
            return val1+200;
        }
    }
   
    public String val2{
        get
        {
            return 'Chocolate';
        }
        set
        {
            val2='Dairy Milk';
        }
    }
    
    public decimal val3{
        get;
        set;
            

    }
    
    private integer x;
    public decimal val4
    {
        
        set
        {
            val4=value*0.9;
            
        }
        get
        {
            return val4+200;
        }
    }
    public void display()
    {
        x=(integer)val;
        System.debug('Private Variable value:'+x);
    }
    
}