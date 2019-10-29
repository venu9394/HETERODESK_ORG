package com.hhcdesk.db;

public class Cl_Queries {

	  protected static StringBuffer PreviewCl;
	  protected static StringBuffer PostCL;
	  protected static StringBuffer HolidayCount;
	  protected static StringBuffer WeakOFF;
	  protected static StringBuffer BetweenDays;
	   
	   static{
		   
		   	PreviewCl=new StringBuffer();
		   	PostCL=new StringBuffer();
		   	HolidayCount=new StringBuffer();
		   	WeakOFF=new StringBuffer();
		   	BetweenDays=new StringBuffer();
		   
		   //***** Below query will fetch Leave type and count of days  of previous  input params  2;
		   
		   PreviewCl.append("  SELECT EMPLOYEEID,LEAVEON,LEAVE_COUNT_BT_DAYS ,leave_type FROM hclhrm_prod_others.tbl_emp_leave_report where ");
		   PreviewCl.append("  employeeid=?  and ");
		   PreviewCl.append("  Manager_status in ('A','P') and LEAVEON<=? order by LEAVEON desc limit 1");
		   
		  //***** Below query will fetch Leave type and count of days  of feature input params 2;
		   
		   PostCL.append("  SELECT EMPLOYEEID,FROM_DATE AS LEAVEON,LEAVE_COUNT_BT_DAYS ,leave_type FROM hclhrm_prod_others.tbl_emp_leave_report where ");
		   PostCL.append("  employeeid=?  and ");
		   PostCL.append("  Manager_status in ('A','P') and LEAVEON>=? order by LEAVEON desc limit 1");
		   
		  //*****fetching holiday count   between previous leave from_date and current date todate and holiday & sunday Flag input params 3 ;
		     
		   HolidayCount.append("  select if(qa.COUNT_HOLIDAY>0,count(*),0) HOLIDAY,qa.COUNT_WOFF,qa.COUNT_HOLIDAY from hclhrm_prod.tbl_holidays hl  ");
		   HolidayCount.append("  left join hclhrm_prod.tbl_employee_primary pr  ");
		   HolidayCount.append("  on pr.companyid=hl.businessunitid  ");
		   HolidayCount.append("  left join hclhrm_prod_others.tbl_emp_leave_quota qa on qa.employeeid=pr.employeeid  ");
		   HolidayCount.append("  and qa.YEAR=date_format(CURDATE(),'%Y') and qa.leavetypeid=1  ");
		   HolidayCount.append("  where hl.statusid=1001  ");
		   HolidayCount.append("  and pr.employeesequenceno in (?) and qa.status=1001 and  ");
		   HolidayCount.append("  date_format(hl.holidaydate,'%Y-%m-%d') between date_format(?,'%Y-%m-%d') and  ");
		   HolidayCount.append("  date_format(?,'%Y-%m-%d')  ");
		   
		//***** Weak off and Between Days fetching Query .. input params 4! 
		   
	    /*WeakOFF.append("   SELECT sum(if(DAYNAME(selected_date)='Sunday',1,0)),abs(datediff(? +INTERVAL -1 DAY ,? +INTERVAL 1 DAY)) from ");*/
	    WeakOFF.append("   SELECT sum(if(DAYNAME(selected_date)='Sunday',1,0)),abs(datediff(?,? )) from ");
	    WeakOFF.append("   (select adddate('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) selected_date from ");
	    WeakOFF.append("   (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t0, ");
	    WeakOFF.append("   (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t1, ");
	    WeakOFF.append("   (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t2, ");
	    WeakOFF.append("   (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t3, ");
	    WeakOFF.append("   (select 0 i union select 1 union select 2 union select 3 union select 4 union select 5 union select 6 union select 7 union select 8 union select 9) t4) ");
	    WeakOFF.append("   v WHERE selected_date > ? AND selected_date< ? ");
	   
		 
	    BetweenDays.append("select abs(datediff(? ,?))+1 from dual");
		   
	   }
	   
	   
}
