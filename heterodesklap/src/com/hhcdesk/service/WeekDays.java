package com.hhcdesk.service;

import java.text.SimpleDateFormat;
import java.util.*;

public  class WeekDays{

 Map Saturday=new HashMap();
Map Mont_find_year=new HashMap();
@SuppressWarnings("rawtypes")
ArrayList Sat_Dates=new ArrayList();
@SuppressWarnings("rawtypes")
Set DispMonths = new HashSet();
SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
@SuppressWarnings("rawtypes")
List datesInRange = new ArrayList();
@SuppressWarnings({ "unchecked", "rawtypes", "unused" })
public  Map countWeekendDays(String fdate, String tdate , int First_Sat,int Second_Sat) {
	
	  Calendar calendar = null;
	  Calendar fcalendar =null;
	  Calendar tcalendar =null;
	try{
	  
		   calendar = Calendar.getInstance();
		   fcalendar = Calendar.getInstance();
		   tcalendar = Calendar.getInstance();
		  
	    int year=0,month=0;
	   
	    fcalendar.set(Integer.parseInt(fdate.split("-")[0]), Integer.parseInt(fdate.split("-")[1]) - 1, Integer.parseInt(fdate.split("-")[2]));
	    
	    tcalendar.set(Integer.parseInt(tdate.split("-")[0]), Integer.parseInt(tdate.split("-")[1]) - 1, Integer.parseInt(tdate.split("-")[2]));
	    Saturday.put("SUNDAYS", "0");
	    
	   // System.out.println(fdate + "~Hi this is from calender~" +tdate);
	try{
		
		/*while(fcalendar.equals(tcalendar) || fcalendar.equals(tcalendar)){
			
			System.out.println("Hai i am in f calender equals....!");
			
		}*/
	    while(fcalendar.before(tcalendar) || fcalendar.equals(tcalendar)){
	    
	    	
	    	//System.out.println(fdate + "~Hi in while this is from calender~" +tdate);
	    	
			int dayOfWeek = fcalendar.get(Calendar.DAY_OF_WEEK);
	    	Date result = fcalendar.getTime();
	    	int Month=fcalendar.get(Calendar.MONTH)+1;
	    	int Year=fcalendar.get(Calendar.YEAR);
	    	Mont_find_year.put(""+Month+"", ""+Year+"");
	    	DispMonths.add(""+Month+"");
	    	String Frmtdate = sdf.format(result);
	        datesInRange.add(Frmtdate);
	        Mont_find_year.put(Frmtdate, Frmtdate);
	        fcalendar.add(Calendar.DATE, 1);	
	    }
	}catch(Exception er){
		System.out.println("Error Code ::"+er);
	}
	   int satcount=1,count=1;
		int fmonth=Integer.parseInt(fdate.split("-")[1]);
		int tmonth=Integer.parseInt(tdate.split("-")[1]);
	Iterator iterator = DispMonths.iterator();
	while(iterator.hasNext()){
		String DisDate=iterator.next().toString();
		year=Integer.parseInt( Mont_find_year.get(DisDate).toString());
		month=Integer.parseInt(DisDate);
	    int daysInMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
	    int stat=1;
	    for (int day = 1; day <= daysInMonth; day++) {
	        calendar.set(year, month - 1, day);
	        int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
	        Date date = calendar.getTime();
        	String Frmtdate = sdf.format(date);
        	if(Mont_find_year.get(""+Frmtdate+"")!=null){
            if (dayOfWeek == Calendar.SUNDAY) {
	            Saturday.put("SUNDAYS", count);
	            count++;
	        }if(dayOfWeek == Calendar.SATURDAY){
	        	if(stat==First_Sat||stat==Second_Sat){
	        		Saturday.put("SATCOUNT", satcount);
	        		satcount++;
	        		Sat_Dates.add(Frmtdate);
	        		Saturday.put("SATURDAYS", Sat_Dates );
	        		Saturday.put(Frmtdate, Frmtdate);
	        	}
	        }
        	} // Main if Else;
	        if(dayOfWeek == Calendar.SATURDAY){   	
        		stat++;
              }
	        }
	} 
	  return Saturday;
	  
	}catch(Exception errr){
		System.out.println("errr :: at week days:"+errr);
		return Saturday;
	}
}	
/*public static void main(String args[]){
	WeekDays Obj=new WeekDays();
	
	String fdate="2018-06-02";
    String tdate="2018-06-02";
    int First_Sat=1;
    int Second_Sat=3;
    
	Map mp=Obj.countWeekendDays(fdate,tdate,First_Sat,Second_Sat);
	System.out.println("TOTAL SUNDAYS::: " +mp.get("SUNDAYS"));
	System.out.println("TOTAL SATURDAYS::: " +mp.get("SATURDAYS"));
	System.out.println("SATCOUNT ::: " +mp.get("SATCOUNT"));
	
  }*/
}
