import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_COLS=20;
public final static int NUM_ROWS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    background( 0 );

    // make the manager
    Interactive.make( this );
   
    //your code to declare and initialize buttons goes here
    buttons=new MSButton[20][20];
    for(int i=0;i<20;i++)
    {

        for(int n=0;n<20;n++)
        {
            buttons[i][n]=new MSButton(i,n);
        }
    }
    
    
    setBombs();
    // for(int i=0;i<20;i++)
    // {
    //     for(int n=0;n<20;n++)
    //     {
    //         String bombnums = Integer.toString(buttons[i][n].countBombs(i,n));
    //         buttons[i][n].setLabel(bombnums);
    //     }
    // }

   for(int i=0;i<20;i++)
    {
         for(int n=0;n<20;n++)
         {
             String bombnums = ""+(buttons[i][n].countBombs(i,n));
             buttons[i][n].setLabel(bombnums);
         }
     }


}
public void setBombs()
{
     bombs=new ArrayList <MSButton>();

        for(int n=0;n<16;n++)
        {
            int r=(int)(Math.random()*20);
            int c=(int)(Math.random()*20);
            bombs.add(buttons[r][c]);
            System.out.println(r+"," +c);
        }
}
 

public void draw ()
{
    
     
    
    if(isWon())
    {
        displayWinningMessage();
    }
    //displayLosingMessage();

    // for(int r=0;r<20;r++)
    // {
    //     for(int c=0;c<20;c++)
    //     {
    //         if(buttons[r][c].isClicked()==true&&bombs.contains(buttons[r][c])&&buttons[r][c].isMarked()==false)
    //         {
    //             displayLosingMessage();
    //         }
    //     }
    // }
     
}
public boolean isWon()
{
    for(int i=0;i<bombs.size();i++)
    {
        for(int n=0;n<bombs.size();n++)
        {
            if(bombs.get(i).isMarked()==false)
            {
                return false;
            }

            else if(!bombs.contains(buttons[i][n])&&buttons[i][n].isMarked()==true)
            {
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    fill(255, 0, 0);
    textSize(20);
    String x=new String();
    x="you lose";
   for(int i=1;i<9;i++)
   {
    buttons[11][i].setLabel(x.substring(i-1,i));
   }

  

 }
public void displayWinningMessage()
{
    fill(0,255,0);
    textSize(20);
     String x=new String();
    x="you win";
   for(int i=1;i<8;i++)
   {
    buttons[10][i].setLabel(x.substring(i-1,i));
   }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;

    public MSButton ( int rr, int cc )
    {

         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed==true)
        {
            //System.out.println(2);
            if(marked==false)
            {
            marked=true;
            clicked=true;
            }

            else
            {
            marked=false;
            clicked=false;
            }
        }

        //your code here

        if(buttons[r][c].isClicked()==true&&bombs.contains(buttons[r][c])&&buttons[r][c].isMarked()==false)
        {
            displayLosingMessage();
        }




        if(!bombs.contains(buttons[r][c])&&isValid(r,c-1)==true && buttons[r][c-1].isClicked()==false&&!bombs.contains(buttons[r][c-1])&&countBombs(r,c)==0)
        {
                buttons[r][c-1].mousePressed();
                //System.out.println("1");
        }
          
        if(!bombs.contains(buttons[r][c])&&isValid(r,c+1)==true && buttons[r][c+1].isClicked()==false&&!bombs.contains(buttons[r][c+1])&&countBombs(r,c)==0)
        {
                buttons[r][c+1].mousePressed();
                //System.out.println("2");
        }

      
        if(!bombs.contains(buttons[r][c])&&isValid(r-1,c)==true && buttons[r-1][c].isClicked()==false&&!bombs.contains(buttons[r-1][c])&&countBombs(r,c)==0)
        {
                buttons[r-1][c].mousePressed();
                //System.out.println("3");
        }
      
        if(!bombs.contains(buttons[r][c])&&isValid(r+1,c)==true && buttons[r+1][c].isClicked()==false&&!bombs.contains(buttons[r+1][c])&&countBombs(r,c)==0)
        {
                buttons[r+1][c].mousePressed();
                //System.out.println("4");
        }



         if(!bombs.contains(buttons[r][c])&&isValid(r-1,c-1)==true && buttons[r-1][c-1].isClicked()==false&&!bombs.contains(buttons[r-1][c-1])&&countBombs(r,c)==0)
        {
                buttons[r-1][c-1].mousePressed();
                //System.out.println("1");
        }
          
        if(!bombs.contains(buttons[r][c])&&isValid(r+1,c+1)==true && buttons[r+1][c+1].isClicked()==false&&!bombs.contains(buttons[r+1][c+1])&&countBombs(r,c)==0)
        {
                buttons[r+1][c+1].mousePressed();
                //System.out.println("2");
        }

      
        if(!bombs.contains(buttons[r][c])&&isValid(r-1,c+1)==true && buttons[r-1][c+1].isClicked()==false&&!bombs.contains(buttons[r-1][c+1])&&countBombs(r,c)==0)
        {
                buttons[r-1][c+1].mousePressed();
                //System.out.println("3");
        }
      
        if(!bombs.contains(buttons[r][c])&&isValid(r+1,c-1)==true && buttons[r+1][c-1].isClicked()==false&&!bombs.contains(buttons[r+1][c-1])&&countBombs(r,c)==0)
        {
                buttons[r+1][c-1].mousePressed();
                //System.out.println("4");
        }

        else if(countBombs(r,c)>0)
        {
            String bombnums = Integer.toString(countBombs((int)(y)/20,(int)(x)/20));
            setLabel(bombnums);
        }

    }


    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
        {
            fill(255,0,0);



        }
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        //countBombs((int(x/width)),(int(y/height)));
        //String bombnums = Integer.toString(countBombs((int)(y)/20,(int)(x)/20));
        //setLabel(bombnums);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
      {
        return true;
      }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here

         if(isValid(row,col-1)==true&&bombs.contains(buttons[row][col-1])&&buttons[r][c].isClicked()==true)
        {
                numBombs++;
                //System.out.println("1");
        }
          
        if(isValid(row,col+1)==true&&bombs.contains(buttons[row][col+1])&&buttons[r][c].isClicked()==true)
        {
                numBombs++;
                //System.out.println("2");
        }

      
        if(isValid(row-1,col)==true&&bombs.contains(buttons[row-1][col])&&buttons[r][c].isClicked()==true)
        {
                numBombs++;
                //System.out.println("3");
        }
      
        if(isValid(row+1,col)==true&&bombs.contains(buttons[row+1][col])&&buttons[r][c].isClicked()==true)
        {
                numBombs++;
                //System.out.println("4");
        }




         if(isValid(row-1,col-1)==true&&bombs.contains(buttons[row-1][col-1])&&buttons[r][c].isClicked()==true)
        {
                numBombs++;
                //System.out.println("1");
        }
          
        if(isValid(row+1,col+1)==true&&bombs.contains(buttons[row+1][col+1])&&buttons[r][c].isClicked()==true)
        {
                numBombs++;
                //System.out.println("2");
        }

      
        if(isValid(row-1,col+1)==true&&bombs.contains(buttons[row-1][col+1])&&buttons[r][c].isClicked()==true)
        {
                numBombs++;
                //System.out.println("3");
        }
      
        if(isValid(row+1,col-1)==true&&bombs.contains(buttons[row+1][col-1])&&buttons[r][c].isClicked()==true)
        {
                numBombs++;
                //System.out.println("4");
        }



        //write the numbombs in the square next to the bomb
        return numBombs;
    }
}