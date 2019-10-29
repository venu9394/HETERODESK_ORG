package com.hhcdesk.service;


import com.mysql.jdbc.Connection;
import com.mysql.jdbc.ResultSet;

import java.sql.CallableStatement;
import java.sql.Types;
import java.util.HashMap;
import java.util.Map;

import com.hhcdesk.db.Cl_Queries;
import com.hhcdesk.db.GetDbData;

public class Cl_Validation extends Cl_Queries{	
Map clmap=new HashMap();

public Map Cl_validate(java.sql.Connection conn, java.sql.ResultSet Res, java.sql.PreparedStatement ps,
		String from_date, String to_date, String leave_Type, String username) {
	
	    GetDbData DataObj=new GetDbData();
//	    
//	    System.out.println("HI I AM IN CL VALIDATION");
	    clmap=new HashMap();
//	   
//	    clmap.put("PRE_LEAVE", false);
//	    clmap.put("POST_LEAVE", false);
//	    
//	    clmap.put("PRE_HOLIDAY","0.00");
//	    clmap.put("POST_HOLIDAY","0.00");
//	    clmap.put("POST_BTDAYS","0.00");
//	    clmap.put("PRE_BTDAYS","0.00");
//	    
//	    clmap.put("POST_SUNDAY","0.00");
//	    
//	    clmap.put("PRE_SUNDAY","0.00");
	    
	    clmap.put("LEAVEADD","0");
	  
	   StringBuffer buff=new StringBuffer();
	       
	     buff.append("select procedure.Get_leave_Back_count(?,?)+procedure.Get_leave_Back_count_fast(?,?) as Leave_Add  from dual ");
	     
	     //CallableStatement cStmt;
	 /*    CallableStatement cStmt1;
	     double FirstValue=0;
	     double SecondValue=0;
	     
	     try{
	    	 CallableStatement cStmt = conn.prepareCall(" {call procedure.Get_leave_Back_count_prev_pr(?,?,?) } ");
	     
	     cStmt.setInt(1, Integer.parseInt(username));
	     cStmt.setString(2, from_date);
	     cStmt.registerOutParameter(3, Types.DOUBLE);
	     cStmt.execute();
	     FirstValue = cStmt.getDouble(3);
	     
	     }catch(Exception err){
	    	 err.printStackTrace();
	     }
	     
	     clmap.put("LEAVEADD", ""+FirstValue+"");*/
	     
	    /* try{
		     cStmt1 =  conn.prepareCall(" {? = call procedure.Get_leave_Back_count_fast(?,?) } ");
		     cStmt1.registerOutParameter(1,java.sql.Types.FLOAT);
		     cStmt1.setInt(2, Integer.parseInt(username));
		     cStmt1.setString(3, to_date);
		     cStmt1.execute();
		     SecondValue = cStmt1.getDouble(1);
		     
		     }catch(Exception err){
		    	 err.printStackTrace();
		     }*/
	    
	    Res=null;
		try {
			//ps=conn.prepareStatement(Cl_Queries.PreviewCl.toString());
			
			ps=conn.prepareStatement(buff.toString());
			ps.setInt(1,Integer.parseInt(username));
			ps.setString(2,from_date);
			ps.setInt(3,Integer.parseInt(username));
			ps.setString(4,to_date);
			Res=(ResultSet)DataObj.FetchDataPrepare_2(ps, "PreviewCl",Res,conn);
			//Res=(ResultSet)DataObj.FetchData("Select * from hclhrm_prod.tbl_employee_primary", "UserAuthentiCation", Res ,conn);
			if(Res.next()){
				
				/*if(Res.getString("leave_type").equalsIgnoreCase("CL")){
				clmap.put("PRE_LEAVE", true);
				clmap.put("PRE_LEAVEON", Res.getString("LEAVEON"));
				clmap.put("PRE_LEAVE_COUNT_BT_DAYS", Res.getString("LEAVE_COUNT_BT_DAYS"));
				clmap.put("PRE_leave_type", Res.getString("leave_type"));*/
			//	User_Auth_auth=Res.getInt(1);
				 clmap.put("LEAVEADD", Res.getString("Leave_Add"));
				//}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 
	/*	Res=null;
		try {
			ps=conn.prepareStatement(Cl_Queries.PostCL.toString());
			ps.setInt(1,Integer.parseInt(username));
			ps.setString(2,to_date);
			Res=(ResultSet)DataObj.FetchDataPrepare_2(ps, "PostCL",Res,conn);
			//Res=(ResultSet)DataObj.FetchData("Select * from hclhrm_prod.tbl_employee_primary", "UserAuthentiCation", Res ,conn);
			if(Res.next()){
				
				if(Res.getString("leave_type").equalsIgnoreCase("CL")){
				clmap.put("POST_LEAVE", true);
				clmap.put("POST_LEAVEON", Res.getString("LEAVEON"));
				clmap.put("POST_LEAVE_COUNT_BT_DAYS", Res.getString("LEAVE_COUNT_BT_DAYS"));
				clmap.put("POST_leave_type", Res.getString("leave_type"));
				}
			//	User_Auth_auth=Res.getInt(1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		clmap.put("PRE_SUNDAY", 0);
		clmap.put("PRE_BTDAYS", 0);	
		
		
	if(clmap.get("PRE_LEAVE").toString().equalsIgnoreCase("true") && Integer.parseInt(clmap.get("COUNT_WOFF").toString())>0 ){
		
		Res=null;
		try {
			ps=conn.prepareStatement(Cl_Queries.WeakOFF.toString());
			ps.setString(1,to_date);
			ps.setString(2,clmap.get("PRE_LEAVEON").toString());
			ps.setString(3,clmap.get("PRE_LEAVEON").toString());
			ps.setString(4,to_date);
			Res=(ResultSet)DataObj.FetchDataPrepare_2(ps, "WeakOFF",Res,conn);
			//Res=(ResultSet)DataObj.FetchData("Select * from hclhrm_prod.tbl_employee_primary", "UserAuthentiCation", Res ,conn);
			if(Res.next()){
				clmap.put("PRE_SUNDAY", Res.getString(1));
				clmap.put("PRE_BTDAYS", Res.getString(2));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		Res=null;
		try {
			ps=conn.prepareStatement(Cl_Queries.HolidayCount.toString());
			ps.setInt(1,Integer.parseInt(username));
			ps.setString(2,clmap.get("PRE_LEAVEON").toString());
			ps.setString(3,to_date);
			Res=(ResultSet)DataObj.FetchDataPrepare_2(ps, "HolidayCount",Res,conn);
			//Res=(ResultSet)DataObj.FetchData("Select * from hclhrm_prod.tbl_employee_primary", "UserAuthentiCation", Res ,conn);
			if(Res.next()){
				
				//HOLIDAY,qa.COUNT_WOFF,qa.COUNT_HOLIDAY
				clmap.put("PRE_HOLIDAY", Res.getString("HOLIDAY"));
				clmap.put("COUNT_WOFF", Res.getString("COUNT_WOFF"));
				clmap.put("COUNT_HOLIDAY", Res.getString("COUNT_HOLIDAY"));
				
				
			//	User_Auth_auth=Res.getInt(1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	    
	clmap.put("POST_SUNDAY", "0");
	clmap.put("POST_BTDAYS", "0");
	
if(clmap.get("POST_LEAVE").toString().equalsIgnoreCase("true") ){
		
		Res=null;
		try {
			ps=conn.prepareStatement(Cl_Queries.WeakOFF.toString());
			ps.setString(1,clmap.get("POST_LEAVEON").toString());
			ps.setString(2,to_date);
			ps.setString(3,to_date);
			ps.setString(4,clmap.get("POST_LEAVEON").toString());
			Res=(ResultSet)DataObj.FetchDataPrepare_2(ps, "WeakOFF",Res,conn);
			if(Res.next()){
				clmap.put("POST_SUNDAY", Res.getString(1));
				clmap.put("POST_BTDAYS", Res.getString(2));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		
		
		Res=null;
		try {
			ps=conn.prepareStatement(Cl_Queries.HolidayCount.toString());
			ps.setInt(1,Integer.parseInt(username));
			ps.setString(2,to_date);
			ps.setString(3,clmap.get("POST_LEAVEON").toString());
			Res=(ResultSet)DataObj.FetchDataPrepare_2(ps, "HolidayCount",Res,conn);
			//Res=(ResultSet)DataObj.FetchData("Select * from hclhrm_prod.tbl_employee_primary", "UserAuthentiCation", Res ,conn);
			if(Res.next()){
				
				//HOLIDAY,qa.COUNT_WOFF,qa.COUNT_HOLIDAY
				clmap.put("POST_HOLIDAY", Res.getString("HOLIDAY"));
				clmap.put("COUNT_WOFF", Res.getString("COUNT_WOFF"));
				clmap.put("COUNT_HOLIDAY", Res.getString("COUNT_HOLIDAY"));
				
				
			//	User_Auth_auth=Res.getInt(1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
	}
	
Res=null;
try {
	ps=conn.prepareStatement(Cl_Queries.BetweenDays.toString());
	
	ps.setString(1,to_date );
	ps.setString(2,from_date);
	
	Res=(ResultSet)DataObj.FetchDataPrepare_2(ps, "BetweenDays",Res,conn);
	
	if(Res.next()){
		clmap.put("BetweenDays", Res.getString(1));
	}
	
} catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}	
double Pre_Holidays=0.0;	
double Pre_Sundays=0.0;
double Pre_Count=0.0;
double Pre_WorkingDays=0.0;


double Post_Holidays=0.0;	
double Post_Sundays=0.0;
double Post_Count=0.0;
double Post_WorkingDays=0.0;


clmap.put("Pre_WorkingDays" ,0);
clmap.put("Post_WorkingDays" ,0);

clmap.put("Pre_WorkingDays_status" ,'N');
clmap.put("Post_WorkingDays_status" ,'N');


if(clmap.get("PRE_LEAVE").toString().equalsIgnoreCase("true")){
	
	Pre_Holidays=Double.parseDouble(clmap.get("PRE_HOLIDAY").toString());
	Pre_Sundays=Double.parseDouble(clmap.get("PRE_SUNDAY").toString());
    Pre_Count=Double.parseDouble(clmap.get("PRE_BTDAYS").toString());
    
    if(Pre_Count==0){
        Pre_WorkingDays=0;
       }else{
       	Pre_WorkingDays=Pre_Count-(Pre_Holidays+Pre_Sundays);
       }
    
    //Pre_WorkingDays=Pre_Count-(Pre_Holidays+Pre_Sundays);
    
    
   clmap.put("Pre_WorkingDays" ,""+Pre_WorkingDays+"");
    
   if(Pre_WorkingDays==0){
	   clmap.put("Pre_WorkingDays_status" ,false); 
   }else{
	   clmap.put("Pre_WorkingDays_status" ,true);
   }
  	
}if(clmap.get("POST_LEAVE").toString().equalsIgnoreCase("true")){
	
	Post_Holidays=Double.parseDouble(clmap.get("POST_HOLIDAY").toString());
	Post_Sundays=Double.parseDouble(clmap.get("POST_SUNDAY").toString());
    Post_Count=Double.parseDouble(clmap.get("POST_BTDAYS").toString());
   
    if(Post_Count==0){
     Post_WorkingDays=0;
    }else{
    	Post_WorkingDays=Post_Count-(Post_Holidays+Post_Sundays);
    }
    
   
      clmap.put("Post_WorkingDays" ,""+Post_WorkingDays+"");
    
      if(Post_WorkingDays==0){
   	   clmap.put("Post_WorkingDays_status" ,false); 
      }else{
   	   clmap.put("Post_WorkingDays_status" ,true);
      }
      
    
}
double Leave_Add=0.00;

if( clmap.get("Pre_WorkingDays_status").toString().equalsIgnoreCase("false")){
	
	Leave_Add=Double.parseDouble(clmap.get("PRE_LEAVE_COUNT_BT_DAYS").toString());
}else if(clmap.get("Post_WorkingDays_status").toString().equalsIgnoreCase("false")){
	
	Leave_Add=Double.parseDouble(clmap.get("POST_LEAVE_COUNT_BT_DAYS").toString());
	
}else if(clmap.get("Post_WorkingDays_status").toString().equalsIgnoreCase("false") && clmap.get("Pre_WorkingDays_status").toString().equalsIgnoreCase("false")){
	
	Leave_Add=Double.parseDouble(clmap.get("PRE_LEAVE_COUNT_BT_DAYS").toString()) + Double.parseDouble(clmap.get("POST_LEAVE_COUNT_BT_DAYS").toString());
}
   */
   
	return clmap;
	
   }
}
