<!doctype html>
<html class="fixed">
	<head>
<%@page import="java.util.*" %>
<% 
  
  String Emp_BioData=(String)request.getAttribute("DOJ_DOB");
  String TDSFLAG=(String)session.getAttribute("TDSFLAG");
  String EMP_NAME=(String)session.getAttribute("EMP_NAME");
  
  String ATT_MONTHS=(String)request.getAttribute("ATT_MONTHS");
  
  String  MGRFLAG=(String)session.getAttribute("Manage_Rights");
  String MGRFLAG_S="none";
  if(MGRFLAG!=null && Integer.parseInt(MGRFLAG)>0){
	  
	  MGRFLAG_S=" ";
  }
  
  String  FlexiPolicy_flag=(String)session.getAttribute("FlexiPolicy");
  String FlexiPolicy_pdf="none";
     if(FlexiPolicy_flag!=null && FlexiPolicy_flag.equalsIgnoreCase("Y")){
    	 FlexiPolicy_pdf="";
	  }
   
  
  String  HR_HRMS=(String)session.getAttribute("HR_HRMS");
  if(HR_HRMS!=null && HR_HRMS.equalsIgnoreCase("YES")){
  	HR_HRMS=" ";
  }else{
  	HR_HRMS="none";
  }
  
  Map EMAILDATA=new HashMap();
  try{
    EMAILDATA=(Map)session.getAttribute("EMAILDATA_MAP");
  }catch(Exception Err){
	  
  }
  
%>

<%
	Random rand = new Random();
	int nRand = rand.nextInt(90000) + 10000;
	
%>


	<head>
	<script src="MyAng.js"></script>
<script>

var app = angular.module('myApp', []);
app.controller('formCtrl', function($scope,$http) {
	var Data="";
	$scope.Data_2=<%=ATT_MONTHS%>;
	$scope.Data_1="";
	$scope.Data_3="";
	$scope.xy=1;
	 $scope.Data_1=<%=Emp_BioData%>;
	 
	 
	 
try{
	 $scope.myFunction = function(val) {
		 
		 document.getElementById("errMessage").innerHTML="";
		 document.getElementById("image_scrl").style.display='';
		 document.getElementById("data_load").style.display='none';
		 
		if(val=="My") {
			
			document.getElementById("errMessage").innerHTML="";
				
			document.getElementById("from_1").value="";
			document.getElementById("to_1").value="";
			 
		 var Month_Sel=document.getElementById("Month_Sel").value;
		 var payperiodwise=document.getElementById('Payperiodwise').checked;
		 
		 
		 
		 
		 $scope.Data_1="";
		 
		 $http({
		        method : "POST",
		        url : "Attendance_flexi?Routing=ATTENDANCE_BIO_DATES&ATT_FLAG=MONTHS&Month="+Month_Sel+"&PPWise="+payperiodwise+"",
		        
		        		
		    }).then(function mySucces(response) {
		    	$scope.Data_1 = response.data;
		    	
		    	 document.getElementById("image_scrl").style.display='none';
				 document.getElementById("data_load").style.display='';
				 
		       // alert(response.data);
		    }, function myError(response) {
		        $scope.Data_1 = response.statusText;
		        document.getElementById("image_scrl").style.display='none';
				 document.getElementById("data_load").style.display='';
				 
		    });
		}
		
		if(val=="My_Datas"){
			
			document.getElementById("errMessage").innerHTML="";
			
			var Month_FROM="";
			var Month_TO="";
			
			try{
			 Month_FROM=document.getElementById("from_1").value;
			 Month_TO=document.getElementById("to_1").value;
			
			  // alert(Month_FROM.length +"~haa~"+Month_TO.length );
			 
			 
			}catch(err){
				alert(err.message);
			}
			
			
			var Month_Sel="";
			 if(Month_FROM.length<1 || Month_TO.length<1 ){
				
				
				 document.getElementById("errMessage").innerHTML="Please Select From & To Date";
				 
				 //alert("Please Select From & To Date");
				 
				     return false;
			 } 
			 
			 else if(Month_FROM.length>1 && Month_TO.length>1)
				 {
				 
				 
				    var fromdate = Month_FROM;
					var todate = Month_TO;
					var from = new Date(fromdate);
					var to = new Date(todate);
					
					var diffDays = parseInt((to - from) / (1000 * 60 * 60 * 24));
					var Days = diffDays + 1;
					 // alert(Days);
					  if(Days<0 ){
						    
						  document.getElementById("errMessage").innerHTML='From date should be < To Date';
						  //alert("From date should be < To Date");
						   return false;
						   
					  }else if(Days>60){
						  
						  document.getElementById("errMessage").innerHTML="Please select period of 60 or <60 days only";
					 //alert("Please select period of 60 or <60 days only");
					return false;
					}
				 }
			 
			 $scope.Data_1="";
			 
			 $http({
			        method : "POST",
			        url : "Attendance_flexi?Routing=ATTENDANCE_BIO_DATES&ATT_FLAG=DATES&Month_FROM="+Month_FROM+"&Month_TO="+Month_TO+" ",
			        
			        		
			    }).then(function mySucces(response) {
			    	$scope.Data_1 = response.data;
			    	
			    	 document.getElementById("image_scrl").style.display='none';
					 document.getElementById("data_load").style.display='';
					 
			       // alert(response.data);
			    }, function myError(response) {
			        $scope.Data_1 = response.statusText;
			        
			         document.getElementById("image_scrl").style.display='none';
					 document.getElementById("data_load").style.display='';
					 
			    });
			
			
		}
		
		
		 
		 
	    }
	 
	
		
 		

		   <%-- 	 $scope.Data_1=<%=Emp_BioData%>;
   
 $scope.Data_2=<%=EmpDOB%>;
    $scope.Data_3=<%=HOLIDAYS_PG%>;
  
    $scope.empid = Data.EMPLOYEESEQUENCENO;
    $scope.empname= Data.CALLNAME;
    $scope.emp_doj= Data.DATEOFJOIN;
    $scope.emp_Dep= Data.DEPARTMENT;
    $scope.emp_Des= Data.DESIGNATION;
    $scope.emp_job_type= Data.TYPE;
     --%>
	}catch(err){
		alert("Please Try Again..");
	}
 });
 
 
</script>



<script>

 function ICT_Req(data){
	 
	 document.getElementById("date").value=data.id; 
	 document.getElementById("Requ_Date").innerHTML=data.id;
	 document.getElementById("Responce_Message").innerHTML='';
	 document.getElementById("Responce_Message_btn").style.display='';
	 
	 document.getElementById("Requ_Date_Temp").value=data.name; 
	 
 }

 function AttendanceRequest(){
	 
	 var date_Temp=document.getElementById("Requ_Date_Temp").value;
	 var Data_Split="";
	 var ReQDate="";
	 var FIN="";
	 var FOUT="";
	 var TIME="";
	 
	 try{
	  	Data_Split=date_Temp.split("#");
	  	ReQDate=Data_Split[0];
	  	FIN=Data_Split[1];
	  	FOUT=Data_Split[2];
	  	TIME=Data_Split[3];
	 }catch(err){
		 alert(err);
	 }

 var  ccemail=document.getElementById("tags3").value;
 var toemail=document.getElementById("tags2").value;
 var message=document.getElementById("message").value;

 
    if(toemail.length <4){
    	
    	document.getElementById("Responce_Message").innerHTML="Invalid Reporting Manager e-mail id please check with HR team";
    	document.getElementById("Responce_Message_btn").style.display='';
    	return false;
    	
    } else if(message.length < 3){
    	
    	document.getElementById("Responce_Message").innerHTML="Please Enter Request Message";
    	document.getElementById("Responce_Message_btn").style.display='';
    	return false;
    	
    } 


	 
	   var date=document.getElementById("date").value;
	   var Subject=document.getElementById("Subject").value;
	   
	   //blockFunction('Processing');
	   
		var formData = {toemail:""+toemail+"",ccemail:""+ccemail+"",Routing:"Att_Request",id:""+ReQDate+"",Subject:""+Subject+"",message:""+message+"",FIN:""+FIN+"",FOUT:""+FOUT+"",TIME:""+TIME+"",RanDm:"<%=nRand%>" };
		
	try{
		
		$("#myModal").modal("hide");
		
		//myModalpop
		
		$("#myModalpop").modal("show");
		
		
		  $.ajax({
	          type: "post",
	          url: "Attendance_flexi",
	          data: formData,
	          success: function(responseData, textStatus, jqXHR) {
	              //alert(responseData);
	             // var resp=eval(responseData);
	             try{
	              document.getElementById("Responce_Message").innerHTML=responseData;
	            
	              $("#myModalpop").modal("hide");
	              $("#myModalpop_data").html(responseData);
	              $("#myModalpop").modal("show");
	               setTimeout(UnblockFunction , 2000);   
	            		  
	              document.getElementById("Responce_Message_btn").style.display='none';
	             // alert("date:"+date);
	              //document.getElementById(""+date+"").innerHTML='Processed';
	              document.getElementById(date).style.display='none';
	              document.getElementById(date+"_ST").innerHTML="<span style='color:red'><B>PROCESSED</B></span>";
	             		//document.getElementById("date").value='';
	       	   			//document.getElementById("Subject").value='';
	       	  			document.getElementById("message").value='';
	       	  	 document.getElementById("date").value=""; 
	       	 	 document.getElementById("Requ_Date").innerHTML="";
	       	 	 document.getElementById("Responce_Message").innerHTML='';
	       	 	 document.getElementById("Responce_Message_btn").style.display='none';
	       	 	 document.getElementById("Requ_Date_Temp").value=""; 
	             }catch(err){
	            	 //alert(err);
	             }
	          },
	          error: function(jqXHR, textStatus, errorThrown) {
	              console.log(errorThrown);
	              document.getElementById("Responce_Message").innerHTML=errorThrown;
	              document.getElementById("Responce_Message_btn").style.display='';
	              document.getElementById(date+"_ST").innerHTML="<span style='color:red'><B>Request Faild</B></span>";
	              
	              $("#myModalpop_data").html(errorThrown);
	               $("#myModalpop").modal("show");
	               setTimeout(UnblockFunction , 2000); 
	               
	             // blockFunction(errorThrown);
	             // setTimeout( UnblockFunction() , 3000);
	            //  $('#pagebody').unblock();	
	              
	             // $("#myModal").modal("hide");
	             // alert("Error;");
	          }
	      })
	      
	      
	      
	      
	}catch(err){
		
		//alert(err.value);
	}
	  
 }
 
function UnblockFunction(){
	$("#myModalpop").modal("hide");
 }
 
 function blockFunction(responseData){
	 
	/*  $('#pagebody').block({ 
         message: "<span style='color:red;font-size:16px'>"+responseData+"</span>", 
         css: { border: '0px solid #a00' } 
     }); */
	 
 }
 
 function AttendanceRequest_Month(){
	 
	  // alert("2");
		var formData = {Routing:"ATTENDANCE_BIO_DATES", FromDate:"20-20-11",ToDate:"22-20-1986"  };
	try{
	    $.ajax({
	          type: "post",
	          url: "Attendance_flexi",
	          data: formData,
	          success: function(responseData, textStatus, jqXHR) {
	            
	               var resp=eval(responseData);
	               
				   //alert("resp::"+resp);
				   
				   $scope.Data_1=eval(responseData);
				  
				   //return  eval(responseData);
                     
				   //myFunction('My');
				   
				   
					   
	             /* try{
	             }catch(err){
	            	 alert(err);
	             } */
	          },
	          error: function(jqXHR, textStatus, errorThrown) {
	              console.log(errorThrown);
	              alert("Error;");
	          }
	      })
	}catch(err){
		 alert(err.value);
	}
	return  eval(responseData);
}
 
</script>
		<!-- Basic -->
		<meta charset="UTF-8">

		<title>Hetero Healthcare LTD</title>
          <link rel="icon" href="LOH.png" />
          
		<meta name="keywords" content="HETERO" />
		<meta name="description" content="Hetero">
		<meta name="author" content="Hetero">

		<!-- Mobile Metas -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
		
		<meta http-equiv="X-UA-Compatible" content="IE=8" />

		<!-- Web Fonts  -->
		<link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800|Shadows+Into+Light" rel="stylesheet" type="text/css">

		<!-- Vendor CSS -->
		<link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.css" />
		<link rel="stylesheet" href="assets/vendor/font-awesome/css/font-awesome.css" />
		<link rel="stylesheet" href="assets/vendor/magnific-popup/magnific-popup.css" />
		<!-- <link rel="stylesheet" href="assets/vendor/bootstrap-datepicker/css/datepicker3.css" /> -->
		

		<!-- Specific Page Vendor CSS -->
		<!-- <link rel="stylesheet" href="assets/vendor/jquery-ui/css/ui-lightness/jquery-ui-1.10.4.custom.css" /> -->
 <link rel="stylesheet" href="jqueryui_date.css">
		

		<!-- Theme CSS -->
		<link rel="stylesheet" href="assets/stylesheets/theme.css" />

		<!-- Skin CSS -->
		<link rel="stylesheet" href="assets/stylesheets/skins/default.css" />

		<!-- Theme Custom CSS -->
		<link rel="stylesheet" href="assets/stylesheets/theme-custom.css">

		<!-- Head Libs -->
		<script src="assets/vendor/modernizr/modernizr.js"></script>
		
			<!-- Specific Page Vendor CSS -->
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
		
   <!-- <script src="jquery.js"></script>
  <script src="jqueryui.js"></script> -->
		   <script>
 /*  $( function() {
    
      from = $( "#from_1" )
        .datepicker({
           changeMonth: true,
           changeYear:true,
          dateFormat: "yy-mm-dd",
          maxDate: 0,
          yearRange: '2016:2020',
		  
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        }),
      to = $( "#to_1" ).datepicker({
         changeMonth: true,
         changeYear:true,
		 dateFormat: "yy-mm-dd",
		 maxDate: 0,
		 yearRange: '2016:2020',
		 
		
        
      })
      .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate( this ) );
      });
 
    function getDate( element ) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }
 
      return date;
    }
  } ); */
  $( function() {
  $("#from_1").datepicker({
	  
	  changeMonth: true,
      changeYear:true,
		maxDate : 0,
		dateFormat : 'yy-mm-dd',
		 yearRange: '2016:2020',
		onSelect : function(date) {
			$("#to_1").datepicker('option', 'minDate', date);
		}
	});

	$("#to_1").datepicker({
		changeMonth: true,
        changeYear:true,
        maxDate: 0,
		dateFormat : 'yy-mm-dd',
			 yearRange: '2016:2020'

	});
  });

  </script>
		<!-- <style>
		tbody{
		display:block;
		height:350px;
		width:auto;
		overflow-y:auto;
		}
		thead,tbody tr{
		display:table;
		width:100%;
		table-layout:fixed;
		}
		thead{
		width: calc(100%-4em);
		}
		</style> -->


  <script>
  $( function() {
	  var availableTags = 
		  [
		  "03.saurav@gmail.com",
"1981abhay@gmail.com",
"666puneeth@gmail.com",
"a.k.singh134@gmail.com",
"abhaypatel86@yahoo.com",
"abhijit.jathi2012@gmail.com",
"abhijit.maity97@gmail.com",
"abhishek.garg@heterohealthcare.com",
"abhisheksingh@heterohealthcare.com",
"adityasharma@heterohealthcare.com",
"aftab886629@gmail.com",
"aintwardhiraj@gmail.com",
"ajaykumar.s@heterohealthcare.com",
"ajayshinde14@gmail.com",
"ajit.linge@gmail.com",
"ajitkumaralkem@gmail.com",
"aksahoo@heterohealthcare.com",
"aliahmed@heterohealthcare.com",
"alok.p@heterohealthcare.com",
"alok2007@rediffmail.com",
"amaroajmire@gmail.com",
"amarvyas79@gmail.com",
"ameet.upadhyay31@gmail.com",
"amin.shaikh81@yahoo.com",
"amit.joshi@heterohealthcare.com",
"amit.s@heterohealthcare.com",
"amithetero12@gmail.com",
"amitmondal210981@yahoo.com",
"amitnarwal1980@gmail.com",
"amitsaha1976@yahoo.co.in",
"amitverma5060@gmail.com",
"amman_ullah90@yahoo.com",
"amol.kalbage@gmail.com",
"amolphule83@gmail.com",
"amsrinivas.genx@gmail.com",
"anand9452834006@gmail.com",
"aneeskhan8522@gmail.com",
"anilbhandari29@gmail.com",
"anjan.roychowdhury15@gmail.com",
"ankittripathi.742@rediffmail.com",
"ankitvi1@gmail.com",
"antoni.gounder@heterohealthcare.com",
"anuj7162@gmail.com",
"anujdewani@heterohealthcare.com",
"anupamsuneet@gmail.com",
"anuradha@heterohealthcare.com",
"anuragkumarpatel1983@gmail.com",
"anwar.shaik@heterohealthcare.com",
"apoorva12890@gmail.com",
"arbindks@rediffmail.com",
"ardendu_swift@rediffmail.com",
"arijit.dutta@heterohealthcare.com",
"arunmishra010@gmail.com",
"arup@heterohealthcare.com",
"arupmuk77@yahoo.com",
"arvind.mishra768@gmail.com",
"arvindabbottsingh@gmail.com",
"arvindsidana85@yahoo.co.in",
"arvindyadav1036@yahoo.com",
"ashaygawade@gmail.com",
"ashish.phl@gmail.com",
"ashutosh00784@gmail.com",
"ashutosh_glenmark@yahoo.com",
"asim.shataxi@rediffmail.com",
"ateeqahmed786@gmail.com",
"atul.salve@heterohealthcare.com",
"audayvansi1@gmail.com",
"aurokanta.m@heterohealthcare.com",
"avadhesh.r@heterohealthcare.com",
"avadhut.sas@gmail.com",
"avadhutsangar85@gmail.com",
"aveshsrivastav.fdc@gmail.com",
"avinash.koturwar1984@gmail.com",
"ayanbal@gmail.com",
"ayyaj.mulla@gmail.com",
"b.behuria@rediffmail.com",
"b.jena@heterohealthcare.com",
"babuveeresh6@gmail.com",
"bajirao.karande@heterohealthcare.com",
"balajune693@gmail.com",
"balaskh1100@gmail.com",
"baldevrampatel@rediffmail.com",
"bangal.soumen@gmail.com",
"banik_abhijeet@rediffmail.com",
"basavarajyaligar7@gmail.com",
"basheerali.nzb@gmail.com",
"bhanupratap@heterohealthcare.com",
"bharat.gehalot@heterohealthcare.com",
"bharatpandya@heterohealthcare.com",
"bharatsiddy@yahoo.com",
"bhaskarasarma_my@yahoo.com",
"bhaveshsavalia2006@yahoo.co.in",
"bhavin_shah7887@yahoo.co.in",
"bhayekar_hhl1@yahoo.com",
"bhushan.yewale@heterohealthcare.com",
"bijay_zephyr@rediffmail.com",
"birendra.y@heterohealthcare.com",
"bj_ajwalia05@yahoo.co.in",
"bm.nagamuthuraja@yahoo.co.in",
"bose@heterohealthcare.com",
"brajgaurav@azistaindustries.com",
"brijeshsharma@heterohealthcare.com",
"bsk.hussain@yahoo.com",
"bulbulekishor@gmail.com",
"bunke_hemant@rediffmail.com",
"cgajjar19@gmail.com",
"chakrabortyindrajit5@gmail.com",
"chandankumar.singh@heterohealthcare.com",
"chandrashekhar@heterohealthcare.com",
"charan.chandana@gmail.com",
"charanpreet.singh@heterohealthcare.com",
"chaubey.pramod@gmail.com",
"chetan.marne26@gmail.com",
"chhavvie@gmail.com",
"chiragkanugo@rocketmail.com",
"chiragsetia15@gmail.com",
"chiranjeevi.velagala@heterohealthcare.com",
"cprasad80@rediffmail.com",
"creativepravesh@gmail.com",
"csreddy@heterohealthcare.com",
"damodararao.m@heterohealthcare.com",
"dattanivas123@gmail.com",
"dattatraya.d@heterohealthcare.com",
"dayasuryawanshi15@gmail.com",
"debasishkol90@gmail.com",
"deepakdhunna96@gmail.com",
"deepaksharma@heterohealthcare.com",
"deshmukh.v@heterohealthcare.com",
"dev.com36@gmail.com",
"devendra.pal2009@gmail.com",
"devijay.pharma@gmail.com",
"dhananjay.sandve@heterohealthcare.com",
"dhaval.patel@heterohealthcare.com",
"dhruvparmar16@gmail.com",
"diaspaahmedabad.asm@heterohealthcare.com",
"diaspaaurangabad.asm@heterohealthcare.com",
"diaspabangalore.asm@heterohealthcare.com",
"diaspabaroda.asm@heterohealthcare.com",
"diaspabhopal.asm@heterohealthcare.com",
"diaspabhubaneswar.asm@heterohealthcare.com",
"diaspacalicut.asm@heterohealthcare.com",
"diaspachandigarh.asm@heterohealthcare.com",
"diaspachennai.asm1@heterohealthcare.com",
"diaspachennai.asm2@heterohealthcare.com",
"diaspacoimbatore.asm@heterohealthcare.com",
"diaspacoimbatore.fe2@heterohealthcare.com",
"diaspacuttack.asm@heterohealthcare.com",
"diaspadelhi.asm1@heterohealthcare.com",
"diaspadelhi.asm2@heterohealthcare.com",
"diaspadelhi.asm3@heterohealthcare.com",
"diaspaernakulam.asm@heterohealthcare.com",
"diaspaguwahati.asm@heterohealthcare.com",
"diaspahowrah.asm@heterohealthcare.com",
"diaspahubli.asm@heterohealthcare.com",
"diaspahyderabad.asm1@heterohealthcare.com",
"diaspahyderabad.asm2@heterohealthcare.com",
"diaspaindore.asm@heterohealthcare.com",
"diaspajabalpur.asm@heterohealthcare.com",
"diaspajaipur.asm@heterohealthcare.com",
"diaspajodhpur.asm@heterohealthcare.com",
"diaspakanpur.asm@heterohealthcare.com",
"diaspakolhapur.asm@heterohealthcare.com",
"diaspakolkata.asm1@heterohealthcare.com",
"diaspakolkata.asm2@heterohealthcare.com",
"diaspakolkata.fe3@heterohealthcare.com",
"diaspakurnool.asm@heterohealthcare.com",
"diaspalucknow.asm@heterohealthcare.com",
"diaspaludhiana.asm@heterohealthcare.com",
"diaspamadurai.asm@heterohealthcare.com",
"diaspamangalore.asm@heterohealthcare.com",
"diaspameerut.asm@heterohealthcare.com",
"diaspamumbai.asm1@heterohealthcare.com",
"diaspamumbai.asm2@heterohealthcare.com",
"diaspamumbai.asm3@heterohealthcare.com",
"diaspamuzaffarpur.asm@heterohealthcare.com",
"diaspanagpur.asm@heterohealthcare.com",
"diaspanavsari.fe@heterohealthcare.com",
"diaspapatna.asm@heterohealthcare.com",
"diaspapune.asm1@heterohealthcare.com",
"diaspapune.asm2@heterohealthcare.com",
"diasparajkot.asm@heterohealthcare.com",
"diasparanchi.asm@heterohealthcare.com",
"diaspasilchar.asm@heterohealthcare.com",
"diaspasiliguri.asm@heterohealthcare.com",
"diaspasrinagar.asm@heterohealthcare.com",
"diaspavaranasi.asm@heterohealthcare.com",
"diaspavijayawada.asm@heterohealthcare.com",
"diaspavizag.asm@heterohealthcare.com",
"dibyendu.roy@heterohealthcare.com",
"dilip.t@heterohealthcare.com",
"dineshkumark2011@yahoo.com",
"divya.srinivasulu@yahoo.com",
"dk_awasthi123@rediffmail.com",
"dp9702@gmail.com",
"dpdrl194@rediffmail.com",
"dpkk1987@gmail.com",
"dr.indrajeetkumar@gmail.com",
"dvk.ravishankar@heterohealthcare.com",
"dvshivajirao@gmail.com",
"fakrushaik744@gmail.com",
"g.senthilhetero@gmail.com",
"gaikwadmd2007@rediffmail.com",
"gallasarathmba@gmail.com",
"ganesh.kale@heterohealthcare.com",
"gangadhartarlekar@yahoo.in",
"gargjai_143@yahoo.co.in",
"gaurav@heterohealthcare.com",
"gautam_p10@yahoo.in",
"genxhardeep@gmail.com",
"girishgorekar@gmail.com",
"gonthinabp@gmail.com",
"goswaminitin0007@gmail.com",
"gunda.srikanth@gmail.com",
"guptaadesh88@yahoo.com",
"guptashashikant71@gmail.com",
"hadibandhumajhi@yahoo.co.in",
"harikant4@gmail.com",
"harish_hetro@yahoo.com",
"harshapalyam@gmail.com",
"heeralal.babu@rediffmail.com",
"hemant.patil@heterohealthcare.com",
"hemant.thakur@heterohealthcare.com",
"hemantrm121@gmail.com",
"heteroashok@gmail.com",
"heteromau@gmail.com",
"heterovikram@gmail.com",
"himanshubhatia.smu@gmail.com",
"hiradhar@heterohealthcare.com",
"imlakkhan@gmail.com",
"imran.1692@rediffmail.com",
"indrajeetrajput87@gmail.com",
"indreshbkumar@gmail.com",
"jadhavprashant001@gmail.com",
"jagdish.n@heterohealthcare.com",
"jainendrabagdaniya@gmail.com",
"jeet1103@gmail.com",
"jeet87@rocketmail.com",
"jigar.shah@heterohealthcare.com",
"jignesh.patel@heterohealthcare.com",
"jintu_daimari@yahoo.com",
"jitendra.lim@gmail.com",
"jitendrasingh@heterohealthcare.com",
"jitheshkumar2007@yahoo.co.in",
"jolly.k@heterohealthcare.com",
"joyanta.banerjee@rediffmail.com",
"jskayastha@gmail.com",
"kaalinga.narayan@azistaindustries.com",
"kallolchakraborti@yahoo.co.in",
"kalpana.sinkar@heterohealthcare.com",
"kalyandas@heterohealthcare.com",
"kambam2@rediffmail.com",
"kanahaiya.tc3@gmail.com",
"kapilksharma85@gmail.com",
"kapilmukati@heterohealthcare.com",
"kapsepawan@rediffmail.com",
"karanhetero@gmail.com",
"karthik.m@heterohealthcare.com",
"kashinath.sontakke@yahoo.com",
"kdaraji007@gmail.com",
"kdesai17@gmail.com",
"khanna_shivam21@rediffmail.com",
"khare.mudit@rediffmail.com",
"khasgiwal@heterohealthcare.com",
"khasim_khan464@yahoo.co.in",
"khatiksamir@gmail.com",
"khatrilokesh52@gmail.com",
"khetanaashish@yahoo.com",
"kiran.singh@heterohealthcare.com",
"kisanlalge@gmail.com",
"kishan.k@heterohealthcare.com",
"kishore.mk18@gmail.com",
"kothireddyravinderreddy@gmail.com",
"koti.mba34@gmail.com",
"kotireddy.mekala2@gmail.com",
"kotireddy@heterohealthcare.com",
"kpandey251@gmail.com",
"ksthakur02@gmail.com",
"ksvitthal@gmail.com",
"kuldip.rathour@gmail.com",
"kumar.kn.83@gmail.com",
"kumar.shambhu860@gmail.com",
"kumarjanga@yahoo.com",
"kumarsnlsinha183@gmail.com",
"kumarswamyheterohealthcare@gmail.com",
"kundu.abhijit4@gmai.com",
"kvkreddy@heterohealthcare.com",
"lakshman_kundur@yahoo.co.in",
"lakshmesh77@gmail.com",
"m.imranrosan1993@gmail.com",
"madan.d@heterohealthcare.com",
"mahaveerdevrath@yahoo.com",
"mahesh.s@heterohealthcare.com",
"mahesh5gunjite@yahoo.co.in",
"maheshgs123@gmail.com",
"mail2syedjaveed@gmail.com",
"majumdaramit41@gmail.com",
"manash@heterohealthcare.com",
"manasp@heterohealthcare.com",
"manbolokhande@gmail.com",
"mangesh.p@heterohealthcare.com",
"mangeshawate2011@gmail.com",
"mangeshpaswan@yahoo.co.in",
"mani.ps@heterohealthcare.com",
"manikanta.atyam@gmail.com",
"manish958@gmail.com",
"manishhaya@gmail.com",
"manishshingh2689@gmail.com",
"manish_nadkar@yahoo.com",
"mankarand@heterohealthcare.com",
"manoj.pahwa@live.com",
"manoj.saxena@heterohealthcare.com",
"manoj@heterohealthcare.com",
"manojsingh@heterohealthcare.com",
"masoomsarwar@gmail.com",
"mayurgutpa636@gmail.com",
"meetmyheart@ymail.com",
"mgajendra82@gmail.com",
"mgaswani@yahoo.in",
"mitulpatel@heterohealthcare.com",
"mmpl.chandru@gmail.com",
"mohannavalav@gmail.com",
"momjidabhi@gmail.com",
"mona.kazi@heterohealthcare..com",
"monu4546@gmail.com",
"mr.nasir21@rediffmail.com",
"mrkrvarma@yahoo.in",
"msyogesh92@gmail.com",
"mudassar.inamdar@rediffmail.com",
"mufaddalbhavti@gmail.com",
"mukeshgupta@heterohealthcare.com",
"murale_satish@rediffmail.com",
"murli_kdm06@yahoo.com",
"murthy_narasimha@yahoo.in",
"mushtaq_rs@yahoo.co.in",
"nagar.sanjeev79@gmail.com",
"nagaraju.v@heterohealthcare.com",
"namamipandey@heterohealthcare.com",
"nandlal.s@heterohealthcare.com",
"nandu.bdm@gmail.com",
"narayanankannan01@gmail.com",
"narendra84trivedi@gmail.com",
"naveen_deshpande9@yahoo.com",
"nazef@heterohealthcare.com",
"neerajhetero@gmail.com",
"nehru.dadisetti@heterohealthcare.com",
"nemai.mukherjee@heterohealthcare.com",
"nigam_sameer@yahoo.com",
"niharrsilu1983@gmail.com",
"nikunj1987joshi@gmail.com",
"nikunjdave1114@yahoo.co.in",
"nilay.chatterjee@heterohealthcare.com",
"nileshpatel@heterohealthcare.com",
"niraj.shah@azistaspace.com",
"niranjan.chanamala@yahoo.com",
"nirav.bhatt@heterohealthcare.com",
"nirav_sheth2110@yahoo.co.in",
"nishaar25@gmail.com",
"nishant.emcure@gmail.com",
"nishanth.d@heterohealthcare.com",
"nishu_sweetbacha089@yahoo.com",
"nitin9oct@gmail.com",
"nitinb@heterohealthcare.com",
"nitinpatil1986@yahoo.co.in",
"nnramesh70@yahoo.co.in",
"obulareddy.pbc@heterohealthcare.com",
"om.ashish6852@gmail.com",
"omkar.yadav@heterohealthcare.com",
"omprakash.b@heterohealthcare.com",
"omprakash.swami@heterohealthcare.com",
"onkardas@gmail.com",
"p.munivel@gmail.com",
"palashdas@heterohealthcare.com",
"palnarendra88@gmail.com",
"pandeylesante1979@gmail.com",
"pankaj.dubey@heterohealthcare.com",
"pankaj.dwivedi110@gmail.com",
"pankaj.surendra.sharma@gmail.com",
"pankajkumar.r@heterohealthcare.com",
"pankajneve2012@gmail.com",
"pankajvyaskaithal@yahoo.com",
"paresh_jarande@rediffmail.com",
"parveenkumar333@gmail.com",
"pathak87pawan@gmail.com",
"pathakamitj@gmail.com",
"patil.hetero@gmail.com",
"pattnaiklipu@gmail.com",
"pavanborle_hhl1@yahoo.com",
"pdubey1947@rediffmail.com",
"peertalib11@gmail.com",
"pingal.1982@gmail.com",
"pp.pareek@gmail.com",
"pra.patel18@gmail.com",
"prabhat.kumar481@gmail.com",
"prabhatsharma394@gmail.com",
"prabhulove.dwivedi@gmail.com",
"pradeepmalandkar1903@gmail.com",
"pradeepmishra@heterohealthcare.com",
"pradip.3june@gmail.com",
"pradip.chavan84@gmail.com",
"prajithlaxman@gmail.com",
"pranava.kj@gmail.com",
"prasanna0501@rediffmail.com",
"prasannavarma29@yahoo.com",
"prashant@heterohealthcare.com",
"prashantdumma@gmail.com",
"prashanthd@heterohealthcare.com",
"prateek.jain@heterohealthcare.com",
"praveengupta11828@gmail.com",
"praveshtiwari82@gmail.com",
"pravin26.p@gmail.com",
"pravir.k.srivastava@gmail.com",
"psgpso@rediffmail.com",
"ptamrakar.9012@gmail.com",
"puneet24janv@gmail.com",
"purnendu.kar1@gmail.com",
"pushpaksonawane26@gmail.com",
"pushpendar_kumar@yahoo.com",
"r.hospure31@gmail.com",
"radhakrishna.pharma@gmail.com",
"raghavendran.vedam@azistaaerospace.com",
"raghupathijatti@gmail.com",
"raghuvendra.singh@heterohealthcare.com",
"rahu.lanke@gmail.com",
"rahuldhamande21@gmail.com",
"rajaislam7@gmail.com",
"rajanaristo52@gmail.com",
"rajarims@gmail.com",
"raja_bhaskar@yahoo.com",
"rajeev.awasthi.ps@gmail.com",
"rajeevojha.ojha30@gmail.com",
"rajeevranjanmukund@yahoo.in",
"rajendra.rajendra029@gmail.com",
"rajendra291987@gmail.com",
"rajesh.todupunuri4447@gmail.com",
"rajeshdharmik12@gmail.com",
"rajeshsodha409@gmail.com",
"rajiv.zenovz@yahoo.in",
"rajkaushikmeerut2mumbai@gmail.com",
"rajsinghemure@gmail.com",
"raju.budime1@gmail.com",
"raju.shanmuki01@gmail.com",
"rakesh.singh@heterohealthcare.com",
"rakeshdhamde@gmail.com",
"ramanuj.banerjee@heterohealthcare.com",
"ramanuja@heterohealthcare.com",
"ramaswamy.v@heterohealthcare.com",
"ramesh.chimurkar@heterohealthcare.com",
"rameshdeepi101@gmail.com",
"rameshmishra6761@gmail.com",
"rane@heterohealthcare.com",
"rathore.dops@gmail.com",
"ratnadeep_paul@yahoo.com",
"ravaljignesh83@gmail.com",
"ravi.k@heterohealthcare.com",
"ravichandra@heterohealthcare.com",
"ravindrakhose2011@gmail.com",
"ravisaini533@gmail.com",
"ravish9211@gmail.com",
"raviswaraj@gmail.com",
"rawal_sun@yahoo.com",
"rishishukla@heterohealthcare.com",
"ritamore210@gmail.com",
"riteshde@gmail.com",
"rkreddy.ch@heterohealthcare.com",
"rmheterofrenza@gmail.com",
"rofiqulislam98@yahoo.com",
"rohitks.genx@gmail.com",
"rrbsamy@gmail.com",
"rsaravanaguru@gmail.com",
"ruturajpawar11@gmail.com",
"s@heterohealthcare.com",
"sachinbangar38@gmail.com",
"sachinghuge33@gmail.com",
"sachinpadwal24@gmail.com",
"sachinrahate@heterohealthcare.com",
"sachinshah9958@gmail.com",
"sadrulali@heterohealthcare.com",
"saheebn@gmail.com",
"saikatchakraborty@heterohealthcare.com",
"saikumar.b@heterohealthcare.com",
"sam.shinde67@gmail.com",
"sameer11105@gmail.com",
"samya1069@gmail.com",
"sandeepbejjanki966@gmail.com",
"sandeepdeongp@yahoo.in",
"sandhya@heterohealthcare.com",
"sandipgodbole_2008@rediffmail.com",
"sandiplonari@gmail.com",
"sangam.partap45@gmail.com",
"sanjay.hetero@gmail.com",
"sanjay.thobhani@azistaspace.com",
"sanjayalk.sk@gmail.com",
"sanjaypandeyhhcl@gmail.com",
"sanjeet.hetero@gmail.com",
"sanjeev.m@heterohealthcare.com",
"sanjibb66@gmail.com",
"sanjivhhl@gmail.com",
"sanjoy.barasat.sutta@gmail.com",
"santhoshreddy.y@heterohealthcare.com",
"santhu_1163@yahoo.com",
"santoshkhamgal@gmail.com",
"sarabindu.ghosh1986@gmail.com",
"sarvesh.gupta2012@gmail.com",
"satish.verma@heterohealthcare.com",
"satishabbott@gmail.com",
"satishpa6761@gmail.com",
"satyam85kumar@gmail.com",
"saxenagaurav2009@gmail.com",
"say2mohan@gmail.com",
"sbelmanchi@gmail.com",
"sdprasad@heterohealthcare.com",
"sebabrata@heterohealthcare.com",
"seemakadam76@yahoo.com",
"sendtosumesh@gmail.com",
"senthilsch@yahoo.co.in",
"sgd310@gmail.com",
"shah.alam81@gmail.com",
"shahminkal2006@yahoo.co.in",
"shahnish26@gmail.com",
"shailesh@heterohealthcare.com",
"shail_kgpharma@yahoo.com",
"shantaram.p@heterohealthcare.com",
"shantaram@heterohealthcare.com",
"sharad@heterohealthcare.com",
"sharma.chandan54@gmial.com",
"sharmaamit342@gmail.com",
"sharmashrikrishna38@gmail.com",
"sharmisthabose1985@gmail.com",
"shashikanth_mr@yahoo.co.in",
"shastri@heterohealthcare.com",
"sheetal@heterohealthcare.com",
"shravan.reddy@heterohealthcare.com",
"shreekant.panigrahi@gmail.com",
"shreyas.krishetero@gmail.co",
"shri.tambade@gmail.com",
"shrirang.bapat@heterohealthcare.com",
"shritakate@gmail.com",
"shubhadeep2003@rediffmail.com",
"shyamendrafdc@gmail.com",
"siddunbl@gmail.com",
"sikandar@heterohealthcare.com",
"sisodiadevendra@yahoomail.com",
"sk.khuntia87@gmail.com",
"sk.valli28@gmail.com",
"sk.wale@rediffmail.com",
"sm_177@rediffmail.com",
"solankibhavesh121@gmail.com",
"souradipdas89@gmail.com",
"sp.coiabm@heterohealthcare.com",
"sp.hydabm@heterohealthcare.com",
"sp.punabm@heterohealthcare.com",
"sp.thrabm@heterohealthcare.com",
"sp.triabm@heterohealthcare.com",
"sp.vijabm@heterohealthcare.com",
"sps.ppgroups@gmail.com",
"sree0870@gmail.com",
"sridhars@heterohealthcare.com",
"srihari.b@heterohealthcare.com",
"srikanth.lakkaraju@heterohealthcare.com",
"srimuthamil@gmail.com",
"srinivas.gajendrula@heterohealthcare.com",
"srinivasa.ch@heterohealthcare.com",
"srinivasarao.m@heterohealthcare.com",
"srinivassarma@ymail.com",
"srinoo_gajjelli@yahoo.co.in",
"sriramraj.sri@gmail.com",
"srreddy@heterohealthcare.com",
"subash@heterohealthcare.com",
"subburama.ankani@gmail.com",
"subham.mail@gmail.com",
"subhrohetero@gmail.com",
"subrata.chakraborty@heterohealthcare.com",
"subrata1211971@gmail.com",
"sudhirkurale@heterohealthcare.com",
"sudhirnbd@gmail.com",
"sudhir_pinki@yahoo.co.in",
"sufiyanahmed@heterohealthcare.com",
"sugumargenxpharma@gmail.com",
"sumanfrenza@gmail.com",
"suman_172001@yahoo.com",
"sumit.dave@azistaspace.com",
"sumit0151989@gmail.com",
"sumit07libra@gmail.com",
"sumit_muk81@yahoo.com",
"sunil@azistaindustries.com",
"sunilbasate@gmail.com",
"sunilcharak@gmail.com",
"sunilgenxhiv@gmail.com",
"sunilkarna1975@gmail.com",
"sunilkarpe81@rediffmail.com",
"sunilp@heterohealthcare.com",
"suniltiwaridamarua@gmail.com",
"sunilunadkat@heterohealthcare.com",
"sunitgupta@heterohealthcare.com",
"sunnychawlapanipat@gmail.com",
"sureshbabu.n@heterohealthcare.com",
"sureshbabu@heterohealthcare.com",
"sureshmk.mk@gmail.com",
"survase147@gmail.com",
"suryaaaa@gmail.com",
"sushant.mali28@gmail.com",
"susheelgodara27@gmail.com",
"tabitha@heterohealthcare.com",
"tabrose12@gmail.com",
"talk2pranabkr@gmail.com",
"tausifshaikh972@gmail.com",
"tejasp166@gmail.com",
"thangsambi@gmail.com",
"thatsmeshiva@rediffmail.com",
"tiwari.alok031@gmail.com",
"tiwariamit08.2011@rediffmail.com",
"tiwari_vinod2@yahoo.com",
"umapathi.govindan@gmail.com",
"umeshgajbhare@gmail.com",
"umeshsvt@rediffmail.com",
"umesht45@gmail.com",
"uttamvaishnav1947@yahoo.co.in",
"vaibhav.khairnar@heterohealthcare.com",
"vaibhav01kanade@gmail.com",
"varsha.jain86@icloud.com",
"varunt@heterohealthcare.com",
"vasuaeran@gmail.com",
"veena@heterohealthcare.com",
"venkysmart01@yahoo.co.in",
"verma.rajesh225@gmail.com",
"vgp99@rediffmail.com",
"vidyasagar.akuthota@azistaindustries.com",
"vijay.chorghade@gmail.com",
"vijaychorghe01@gmail.com",
"vijaym396@gmail.com",
"vijay_07sheru@yahoo.co.in",
"vikas1979sachdeva@yahoo.co.in",
"vikasjainmittal@gmail.com",
"vik_jadhav77@yahoo.co.in",
"vilaspawale@yahoo.co.in",
"vinayaklawate@gmail.com",
"vineshpournami@gmail.com",
"vinodbhondave27@gmail.com",
"vinodcrema@gmail.com",
"vinodkanawade970@gmail.com",
"vipin.rathi@heterohealthcare.com",
"virender.gumber@gmail.com",
"vishal.pawar@heterohealthcare.com",
"vishal25chandel@gmail.com",
"vishalgulati171986@yahoo.com",
"vishwanathan.iyer@heterohealthcare.com",
"vithal.gangarde@heterohealthcare.com",
"vjygkp@rediffmail.com",
"volga.cheasm@heterohealthcare.com",
"volga.delasm@heterohealthcare.com",
"volga.jaiasm@heterohealthcare.com",
"volga.kolasm@heterohealthcare.com",
"waseem.khanday@gmail.com",
"yahiya_at@yahoo.com",
"yashsalvia@gmail.com",
"yjojireddy@heterohealthcare.com",
"yog.sabale@gmail.com",
"yogendra.dutt@heterohealthcare.com",
"yogendra.paliewal1986@gmail.com",
"yogeshpatil@heterohealthcare.com",
"yogi18487@gmail.com",
"zahid_27sd@yahoo.com"

		  ];
	  
    function split( val ) {
      return val.split( /,\s*/ );
    }
    function extractLast( term ) {
      return split( term ).pop();
    }
    $( ".addresspicker" ).autocomplete({
        source: availableTags
      });
  // $('#myModal').modal('show');
  
    $( "#tags2" )
      // don't navigate away from the field on tab when selecting an item
      .on( "keydown", function( event ) {
        if ( event.keyCode === $.ui.keyCode.TAB &&
            $( this ).autocomplete( "instance" ).menu.active ) {
          event.preventDefault();
        }
      })
      .autocomplete({
        minLength: 0,
        source: function( request, response ) {
          // delegate back to autocomplete, but extract the last term
          response( $.ui.autocomplete.filter(
            availableTags, extractLast( request.term ) ) );
        },
        focus: function() {
          // prevent value inserted on focus
          return false;
        },
        select: function( event, ui ) {
          var terms = split( this.value );
          // remove the current input
          terms.pop();
          // add the selected item
          terms.push( ui.item.value );
          // add placeholder to get the comma-and-space at the end
          terms.push( "" );
          this.value = terms.join( "," );
          return false;
        }
      });
  } );
  </script>
  <script>
  $( function() {
	  var availableTags = 
		  [
		  "03.saurav@gmail.com",
"1981abhay@gmail.com",
"666puneeth@gmail.com",
"a.k.singh134@gmail.com",
"abhaypatel86@yahoo.com",
"abhijit.jathi2012@gmail.com",
"abhijit.maity97@gmail.com",
"abhishek.garg@heterohealthcare.com",
"abhisheksingh@heterohealthcare.com",
"adityasharma@heterohealthcare.com",
"aftab886629@gmail.com",
"aintwardhiraj@gmail.com",
"ajaykumar.s@heterohealthcare.com",
"ajayshinde14@gmail.com",
"ajit.linge@gmail.com",
"ajitkumaralkem@gmail.com",
"aksahoo@heterohealthcare.com",
"aliahmed@heterohealthcare.com",
"alok.p@heterohealthcare.com",
"alok2007@rediffmail.com",
"amaroajmire@gmail.com",
"amarvyas79@gmail.com",
"ameet.upadhyay31@gmail.com",
"amin.shaikh81@yahoo.com",
"amit.joshi@heterohealthcare.com",
"amit.s@heterohealthcare.com",
"amithetero12@gmail.com",
"amitmondal210981@yahoo.com",
"amitnarwal1980@gmail.com",
"amitsaha1976@yahoo.co.in",
"amitverma5060@gmail.com",
"amman_ullah90@yahoo.com",
"amol.kalbage@gmail.com",
"amolphule83@gmail.com",
"amsrinivas.genx@gmail.com",
"anand9452834006@gmail.com",
"aneeskhan8522@gmail.com",
"anilbhandari29@gmail.com",
"anjan.roychowdhury15@gmail.com",
"ankittripathi.742@rediffmail.com",
"ankitvi1@gmail.com",
"antoni.gounder@heterohealthcare.com",
"anuj7162@gmail.com",
"anujdewani@heterohealthcare.com",
"anupamsuneet@gmail.com",
"anuradha@heterohealthcare.com",
"anuragkumarpatel1983@gmail.com",
"anwar.shaik@heterohealthcare.com",
"apoorva12890@gmail.com",
"arbindks@rediffmail.com",
"ardendu_swift@rediffmail.com",
"arijit.dutta@heterohealthcare.com",
"arunmishra010@gmail.com",
"arup@heterohealthcare.com",
"arupmuk77@yahoo.com",
"arvind.mishra768@gmail.com",
"arvindabbottsingh@gmail.com",
"arvindsidana85@yahoo.co.in",
"arvindyadav1036@yahoo.com",
"ashaygawade@gmail.com",
"ashish.phl@gmail.com",
"ashutosh00784@gmail.com",
"ashutosh_glenmark@yahoo.com",
"asim.shataxi@rediffmail.com",
"ateeqahmed786@gmail.com",
"atul.salve@heterohealthcare.com",
"audayvansi1@gmail.com",
"aurokanta.m@heterohealthcare.com",
"avadhesh.r@heterohealthcare.com",
"avadhut.sas@gmail.com",
"avadhutsangar85@gmail.com",
"aveshsrivastav.fdc@gmail.com",
"avinash.koturwar1984@gmail.com",
"ayanbal@gmail.com",
"ayyaj.mulla@gmail.com",
"b.behuria@rediffmail.com",
"b.jena@heterohealthcare.com",
"babuveeresh6@gmail.com",
"bajirao.karande@heterohealthcare.com",
"balajune693@gmail.com",
"balaskh1100@gmail.com",
"baldevrampatel@rediffmail.com",
"bangal.soumen@gmail.com",
"banik_abhijeet@rediffmail.com",
"basavarajyaligar7@gmail.com",
"basheerali.nzb@gmail.com",
"bhanupratap@heterohealthcare.com",
"bharat.gehalot@heterohealthcare.com",
"bharatpandya@heterohealthcare.com",
"bharatsiddy@yahoo.com",
"bhaskarasarma_my@yahoo.com",
"bhaveshsavalia2006@yahoo.co.in",
"bhavin_shah7887@yahoo.co.in",
"bhayekar_hhl1@yahoo.com",
"bhushan.yewale@heterohealthcare.com",
"bijay_zephyr@rediffmail.com",
"birendra.y@heterohealthcare.com",
"bj_ajwalia05@yahoo.co.in",
"bm.nagamuthuraja@yahoo.co.in",
"bose@heterohealthcare.com",
"brajgaurav@azistaindustries.com",
"brijeshsharma@heterohealthcare.com",
"bsk.hussain@yahoo.com",
"bulbulekishor@gmail.com",
"bunke_hemant@rediffmail.com",
"cgajjar19@gmail.com",
"chakrabortyindrajit5@gmail.com",
"chandankumar.singh@heterohealthcare.com",
"chandrashekhar@heterohealthcare.com",
"charan.chandana@gmail.com",
"charanpreet.singh@heterohealthcare.com",
"chaubey.pramod@gmail.com",
"chetan.marne26@gmail.com",
"chhavvie@gmail.com",
"chiragkanugo@rocketmail.com",
"chiragsetia15@gmail.com",
"chiranjeevi.velagala@heterohealthcare.com",
"cprasad80@rediffmail.com",
"creativepravesh@gmail.com",
"csreddy@heterohealthcare.com",
"damodararao.m@heterohealthcare.com",
"dattanivas123@gmail.com",
"dattatraya.d@heterohealthcare.com",
"dayasuryawanshi15@gmail.com",
"debasishkol90@gmail.com",
"deepakdhunna96@gmail.com",
"deepaksharma@heterohealthcare.com",
"deshmukh.v@heterohealthcare.com",
"dev.com36@gmail.com",
"devendra.pal2009@gmail.com",
"devijay.pharma@gmail.com",
"dhananjay.sandve@heterohealthcare.com",
"dhaval.patel@heterohealthcare.com",
"dhruvparmar16@gmail.com",
"diaspaahmedabad.asm@heterohealthcare.com",
"diaspaaurangabad.asm@heterohealthcare.com",
"diaspabangalore.asm@heterohealthcare.com",
"diaspabaroda.asm@heterohealthcare.com",
"diaspabhopal.asm@heterohealthcare.com",
"diaspabhubaneswar.asm@heterohealthcare.com",
"diaspacalicut.asm@heterohealthcare.com",
"diaspachandigarh.asm@heterohealthcare.com",
"diaspachennai.asm1@heterohealthcare.com",
"diaspachennai.asm2@heterohealthcare.com",
"diaspacoimbatore.asm@heterohealthcare.com",
"diaspacoimbatore.fe2@heterohealthcare.com",
"diaspacuttack.asm@heterohealthcare.com",
"diaspadelhi.asm1@heterohealthcare.com",
"diaspadelhi.asm2@heterohealthcare.com",
"diaspadelhi.asm3@heterohealthcare.com",
"diaspaernakulam.asm@heterohealthcare.com",
"diaspaguwahati.asm@heterohealthcare.com",
"diaspahowrah.asm@heterohealthcare.com",
"diaspahubli.asm@heterohealthcare.com",
"diaspahyderabad.asm1@heterohealthcare.com",
"diaspahyderabad.asm2@heterohealthcare.com",
"diaspaindore.asm@heterohealthcare.com",
"diaspajabalpur.asm@heterohealthcare.com",
"diaspajaipur.asm@heterohealthcare.com",
"diaspajodhpur.asm@heterohealthcare.com",
"diaspakanpur.asm@heterohealthcare.com",
"diaspakolhapur.asm@heterohealthcare.com",
"diaspakolkata.asm1@heterohealthcare.com",
"diaspakolkata.asm2@heterohealthcare.com",
"diaspakolkata.fe3@heterohealthcare.com",
"diaspakurnool.asm@heterohealthcare.com",
"diaspalucknow.asm@heterohealthcare.com",
"diaspaludhiana.asm@heterohealthcare.com",
"diaspamadurai.asm@heterohealthcare.com",
"diaspamangalore.asm@heterohealthcare.com",
"diaspameerut.asm@heterohealthcare.com",
"diaspamumbai.asm1@heterohealthcare.com",
"diaspamumbai.asm2@heterohealthcare.com",
"diaspamumbai.asm3@heterohealthcare.com",
"diaspamuzaffarpur.asm@heterohealthcare.com",
"diaspanagpur.asm@heterohealthcare.com",
"diaspanavsari.fe@heterohealthcare.com",
"diaspapatna.asm@heterohealthcare.com",
"diaspapune.asm1@heterohealthcare.com",
"diaspapune.asm2@heterohealthcare.com",
"diasparajkot.asm@heterohealthcare.com",
"diasparanchi.asm@heterohealthcare.com",
"diaspasilchar.asm@heterohealthcare.com",
"diaspasiliguri.asm@heterohealthcare.com",
"diaspasrinagar.asm@heterohealthcare.com",
"diaspavaranasi.asm@heterohealthcare.com",
"diaspavijayawada.asm@heterohealthcare.com",
"diaspavizag.asm@heterohealthcare.com",
"dibyendu.roy@heterohealthcare.com",
"dilip.t@heterohealthcare.com",
"dineshkumark2011@yahoo.com",
"divya.srinivasulu@yahoo.com",
"dk_awasthi123@rediffmail.com",
"dp9702@gmail.com",
"dpdrl194@rediffmail.com",
"dpkk1987@gmail.com",
"dr.indrajeetkumar@gmail.com",
"dvk.ravishankar@heterohealthcare.com",
"dvshivajirao@gmail.com",
"fakrushaik744@gmail.com",
"g.senthilhetero@gmail.com",
"gaikwadmd2007@rediffmail.com",
"gallasarathmba@gmail.com",
"ganesh.kale@heterohealthcare.com",
"gangadhartarlekar@yahoo.in",
"gargjai_143@yahoo.co.in",
"gaurav@heterohealthcare.com",
"gautam_p10@yahoo.in",
"genxhardeep@gmail.com",
"girishgorekar@gmail.com",
"gonthinabp@gmail.com",
"goswaminitin0007@gmail.com",
"gunda.srikanth@gmail.com",
"guptaadesh88@yahoo.com",
"guptashashikant71@gmail.com",
"hadibandhumajhi@yahoo.co.in",
"harikant4@gmail.com",
"harish_hetro@yahoo.com",
"harshapalyam@gmail.com",
"heeralal.babu@rediffmail.com",
"hemant.patil@heterohealthcare.com",
"hemant.thakur@heterohealthcare.com",
"hemantrm121@gmail.com",
"heteroashok@gmail.com",
"heteromau@gmail.com",
"heterovikram@gmail.com",
"himanshubhatia.smu@gmail.com",
"hiradhar@heterohealthcare.com",
"imlakkhan@gmail.com",
"imran.1692@rediffmail.com",
"indrajeetrajput87@gmail.com",
"indreshbkumar@gmail.com",
"jadhavprashant001@gmail.com",
"jagdish.n@heterohealthcare.com",
"jainendrabagdaniya@gmail.com",
"jeet1103@gmail.com",
"jeet87@rocketmail.com",
"jigar.shah@heterohealthcare.com",
"jignesh.patel@heterohealthcare.com",
"jintu_daimari@yahoo.com",
"jitendra.lim@gmail.com",
"jitendrasingh@heterohealthcare.com",
"jitheshkumar2007@yahoo.co.in",
"jolly.k@heterohealthcare.com",
"joyanta.banerjee@rediffmail.com",
"jskayastha@gmail.com",
"kaalinga.narayan@azistaindustries.com",
"kallolchakraborti@yahoo.co.in",
"kalpana.sinkar@heterohealthcare.com",
"kalyandas@heterohealthcare.com",
"kambam2@rediffmail.com",
"kanahaiya.tc3@gmail.com",
"kapilksharma85@gmail.com",
"kapilmukati@heterohealthcare.com",
"kapsepawan@rediffmail.com",
"karanhetero@gmail.com",
"karthik.m@heterohealthcare.com",
"kashinath.sontakke@yahoo.com",
"kdaraji007@gmail.com",
"kdesai17@gmail.com",
"khanna_shivam21@rediffmail.com",
"khare.mudit@rediffmail.com",
"khasgiwal@heterohealthcare.com",
"khasim_khan464@yahoo.co.in",
"khatiksamir@gmail.com",
"khatrilokesh52@gmail.com",
"khetanaashish@yahoo.com",
"kiran.singh@heterohealthcare.com",
"kisanlalge@gmail.com",
"kishan.k@heterohealthcare.com",
"kishore.mk18@gmail.com",
"kothireddyravinderreddy@gmail.com",
"koti.mba34@gmail.com",
"kotireddy.mekala2@gmail.com",
"kotireddy@heterohealthcare.com",
"kpandey251@gmail.com",
"ksthakur02@gmail.com",
"ksvitthal@gmail.com",
"kuldip.rathour@gmail.com",
"kumar.kn.83@gmail.com",
"kumar.shambhu860@gmail.com",
"kumarjanga@yahoo.com",
"kumarsnlsinha183@gmail.com",
"kumarswamyheterohealthcare@gmail.com",
"kundu.abhijit4@gmai.com",
"kvkreddy@heterohealthcare.com",
"lakshman_kundur@yahoo.co.in",
"lakshmesh77@gmail.com",
"m.imranrosan1993@gmail.com",
"madan.d@heterohealthcare.com",
"mahaveerdevrath@yahoo.com",
"mahesh.s@heterohealthcare.com",
"mahesh5gunjite@yahoo.co.in",
"maheshgs123@gmail.com",
"mail2syedjaveed@gmail.com",
"majumdaramit41@gmail.com",
"manash@heterohealthcare.com",
"manasp@heterohealthcare.com",
"manbolokhande@gmail.com",
"mangesh.p@heterohealthcare.com",
"mangeshawate2011@gmail.com",
"mangeshpaswan@yahoo.co.in",
"mani.ps@heterohealthcare.com",
"manikanta.atyam@gmail.com",
"manish958@gmail.com",
"manishhaya@gmail.com",
"manishshingh2689@gmail.com",
"manish_nadkar@yahoo.com",
"mankarand@heterohealthcare.com",
"manoj.pahwa@live.com",
"manoj.saxena@heterohealthcare.com",
"manoj@heterohealthcare.com",
"manojsingh@heterohealthcare.com",
"masoomsarwar@gmail.com",
"mayurgutpa636@gmail.com",
"meetmyheart@ymail.com",
"mgajendra82@gmail.com",
"mgaswani@yahoo.in",
"mitulpatel@heterohealthcare.com",
"mmpl.chandru@gmail.com",
"mohannavalav@gmail.com",
"momjidabhi@gmail.com",
"mona.kazi@heterohealthcare..com",
"monu4546@gmail.com",
"mr.nasir21@rediffmail.com",
"mrkrvarma@yahoo.in",
"msyogesh92@gmail.com",
"mudassar.inamdar@rediffmail.com",
"mufaddalbhavti@gmail.com",
"mukeshgupta@heterohealthcare.com",
"murale_satish@rediffmail.com",
"murli_kdm06@yahoo.com",
"murthy_narasimha@yahoo.in",
"mushtaq_rs@yahoo.co.in",
"nagar.sanjeev79@gmail.com",
"nagaraju.v@heterohealthcare.com",
"namamipandey@heterohealthcare.com",
"nandlal.s@heterohealthcare.com",
"nandu.bdm@gmail.com",
"narayanankannan01@gmail.com",
"narendra84trivedi@gmail.com",
"naveen_deshpande9@yahoo.com",
"nazef@heterohealthcare.com",
"neerajhetero@gmail.com",
"nehru.dadisetti@heterohealthcare.com",
"nemai.mukherjee@heterohealthcare.com",
"nigam_sameer@yahoo.com",
"niharrsilu1983@gmail.com",
"nikunj1987joshi@gmail.com",
"nikunjdave1114@yahoo.co.in",
"nilay.chatterjee@heterohealthcare.com",
"nileshpatel@heterohealthcare.com",
"niraj.shah@azistaspace.com",
"niranjan.chanamala@yahoo.com",
"nirav.bhatt@heterohealthcare.com",
"nirav_sheth2110@yahoo.co.in",
"nishaar25@gmail.com",
"nishant.emcure@gmail.com",
"nishanth.d@heterohealthcare.com",
"nishu_sweetbacha089@yahoo.com",
"nitin9oct@gmail.com",
"nitinb@heterohealthcare.com",
"nitinpatil1986@yahoo.co.in",
"nnramesh70@yahoo.co.in",
"obulareddy.pbc@heterohealthcare.com",
"om.ashish6852@gmail.com",
"omkar.yadav@heterohealthcare.com",
"omprakash.b@heterohealthcare.com",
"omprakash.swami@heterohealthcare.com",
"onkardas@gmail.com",
"p.munivel@gmail.com",
"palashdas@heterohealthcare.com",
"palnarendra88@gmail.com",
"pandeylesante1979@gmail.com",
"pankaj.dubey@heterohealthcare.com",
"pankaj.dwivedi110@gmail.com",
"pankaj.surendra.sharma@gmail.com",
"pankajkumar.r@heterohealthcare.com",
"pankajneve2012@gmail.com",
"pankajvyaskaithal@yahoo.com",
"paresh_jarande@rediffmail.com",
"parveenkumar333@gmail.com",
"pathak87pawan@gmail.com",
"pathakamitj@gmail.com",
"patil.hetero@gmail.com",
"pattnaiklipu@gmail.com",
"pavanborle_hhl1@yahoo.com",
"pdubey1947@rediffmail.com",
"peertalib11@gmail.com",
"pingal.1982@gmail.com",
"pp.pareek@gmail.com",
"pra.patel18@gmail.com",
"prabhat.kumar481@gmail.com",
"prabhatsharma394@gmail.com",
"prabhulove.dwivedi@gmail.com",
"pradeepmalandkar1903@gmail.com",
"pradeepmishra@heterohealthcare.com",
"pradip.3june@gmail.com",
"pradip.chavan84@gmail.com",
"prajithlaxman@gmail.com",
"pranava.kj@gmail.com",
"prasanna0501@rediffmail.com",
"prasannavarma29@yahoo.com",
"prashant@heterohealthcare.com",
"prashantdumma@gmail.com",
"prashanthd@heterohealthcare.com",
"prateek.jain@heterohealthcare.com",
"praveengupta11828@gmail.com",
"praveshtiwari82@gmail.com",
"pravin26.p@gmail.com",
"pravir.k.srivastava@gmail.com",
"psgpso@rediffmail.com",
"ptamrakar.9012@gmail.com",
"puneet24janv@gmail.com",
"purnendu.kar1@gmail.com",
"pushpaksonawane26@gmail.com",
"pushpendar_kumar@yahoo.com",
"r.hospure31@gmail.com",
"radhakrishna.pharma@gmail.com",
"raghavendran.vedam@azistaaerospace.com",
"raghupathijatti@gmail.com",
"raghuvendra.singh@heterohealthcare.com",
"rahu.lanke@gmail.com",
"rahuldhamande21@gmail.com",
"rajaislam7@gmail.com",
"rajanaristo52@gmail.com",
"rajarims@gmail.com",
"raja_bhaskar@yahoo.com",
"rajeev.awasthi.ps@gmail.com",
"rajeevojha.ojha30@gmail.com",
"rajeevranjanmukund@yahoo.in",
"rajendra.rajendra029@gmail.com",
"rajendra291987@gmail.com",
"rajesh.todupunuri4447@gmail.com",
"rajeshdharmik12@gmail.com",
"rajeshsodha409@gmail.com",
"rajiv.zenovz@yahoo.in",
"rajkaushikmeerut2mumbai@gmail.com",
"rajsinghemure@gmail.com",
"raju.budime1@gmail.com",
"raju.shanmuki01@gmail.com",
"rakesh.singh@heterohealthcare.com",
"rakeshdhamde@gmail.com",
"ramanuj.banerjee@heterohealthcare.com",
"ramanuja@heterohealthcare.com",
"ramaswamy.v@heterohealthcare.com",
"ramesh.chimurkar@heterohealthcare.com",
"rameshdeepi101@gmail.com",
"rameshmishra6761@gmail.com",
"rane@heterohealthcare.com",
"rathore.dops@gmail.com",
"ratnadeep_paul@yahoo.com",
"ravaljignesh83@gmail.com",
"ravi.k@heterohealthcare.com",
"ravichandra@heterohealthcare.com",
"ravindrakhose2011@gmail.com",
"ravisaini533@gmail.com",
"ravish9211@gmail.com",
"raviswaraj@gmail.com",
"rawal_sun@yahoo.com",
"rishishukla@heterohealthcare.com",
"ritamore210@gmail.com",
"riteshde@gmail.com",
"rkreddy.ch@heterohealthcare.com",
"rmheterofrenza@gmail.com",
"rofiqulislam98@yahoo.com",
"rohitks.genx@gmail.com",
"rrbsamy@gmail.com",
"rsaravanaguru@gmail.com",
"ruturajpawar11@gmail.com",
"s@heterohealthcare.com",
"sachinbangar38@gmail.com",
"sachinghuge33@gmail.com",
"sachinpadwal24@gmail.com",
"sachinrahate@heterohealthcare.com",
"sachinshah9958@gmail.com",
"sadrulali@heterohealthcare.com",
"saheebn@gmail.com",
"saikatchakraborty@heterohealthcare.com",
"saikumar.b@heterohealthcare.com",
"sam.shinde67@gmail.com",
"sameer11105@gmail.com",
"samya1069@gmail.com",
"sandeepbejjanki966@gmail.com",
"sandeepdeongp@yahoo.in",
"sandhya@heterohealthcare.com",
"sandipgodbole_2008@rediffmail.com",
"sandiplonari@gmail.com",
"sangam.partap45@gmail.com",
"sanjay.hetero@gmail.com",
"sanjay.thobhani@azistaspace.com",
"sanjayalk.sk@gmail.com",
"sanjaypandeyhhcl@gmail.com",
"sanjeet.hetero@gmail.com",
"sanjeev.m@heterohealthcare.com",
"sanjibb66@gmail.com",
"sanjivhhl@gmail.com",
"sanjoy.barasat.sutta@gmail.com",
"santhoshreddy.y@heterohealthcare.com",
"santhu_1163@yahoo.com",
"santoshkhamgal@gmail.com",
"sarabindu.ghosh1986@gmail.com",
"sarvesh.gupta2012@gmail.com",
"satish.verma@heterohealthcare.com",
"satishabbott@gmail.com",
"satishpa6761@gmail.com",
"satyam85kumar@gmail.com",
"saxenagaurav2009@gmail.com",
"say2mohan@gmail.com",
"sbelmanchi@gmail.com",
"sdprasad@heterohealthcare.com",
"sebabrata@heterohealthcare.com",
"seemakadam76@yahoo.com",
"sendtosumesh@gmail.com",
"senthilsch@yahoo.co.in",
"sgd310@gmail.com",
"shah.alam81@gmail.com",
"shahminkal2006@yahoo.co.in",
"shahnish26@gmail.com",
"shailesh@heterohealthcare.com",
"shail_kgpharma@yahoo.com",
"shantaram.p@heterohealthcare.com",
"shantaram@heterohealthcare.com",
"sharad@heterohealthcare.com",
"sharma.chandan54@gmial.com",
"sharmaamit342@gmail.com",
"sharmashrikrishna38@gmail.com",
"sharmisthabose1985@gmail.com",
"shashikanth_mr@yahoo.co.in",
"shastri@heterohealthcare.com",
"sheetal@heterohealthcare.com",
"shravan.reddy@heterohealthcare.com",
"shreekant.panigrahi@gmail.com",
"shreyas.krishetero@gmail.co",
"shri.tambade@gmail.com",
"shrirang.bapat@heterohealthcare.com",
"shritakate@gmail.com",
"shubhadeep2003@rediffmail.com",
"shyamendrafdc@gmail.com",
"siddunbl@gmail.com",
"sikandar@heterohealthcare.com",
"sisodiadevendra@yahoomail.com",
"sk.khuntia87@gmail.com",
"sk.valli28@gmail.com",
"sk.wale@rediffmail.com",
"sm_177@rediffmail.com",
"solankibhavesh121@gmail.com",
"souradipdas89@gmail.com",
"sp.coiabm@heterohealthcare.com",
"sp.hydabm@heterohealthcare.com",
"sp.punabm@heterohealthcare.com",
"sp.thrabm@heterohealthcare.com",
"sp.triabm@heterohealthcare.com",
"sp.vijabm@heterohealthcare.com",
"sps.ppgroups@gmail.com",
"sree0870@gmail.com",
"sridhars@heterohealthcare.com",
"srihari.b@heterohealthcare.com",
"srikanth.lakkaraju@heterohealthcare.com",
"srimuthamil@gmail.com",
"srinivas.gajendrula@heterohealthcare.com",
"srinivasa.ch@heterohealthcare.com",
"srinivasarao.m@heterohealthcare.com",
"srinivassarma@ymail.com",
"srinoo_gajjelli@yahoo.co.in",
"sriramraj.sri@gmail.com",
"srreddy@heterohealthcare.com",
"subash@heterohealthcare.com",
"subburama.ankani@gmail.com",
"subham.mail@gmail.com",
"subhrohetero@gmail.com",
"subrata.chakraborty@heterohealthcare.com",
"subrata1211971@gmail.com",
"sudhirkurale@heterohealthcare.com",
"sudhirnbd@gmail.com",
"sudhir_pinki@yahoo.co.in",
"sufiyanahmed@heterohealthcare.com",
"sugumargenxpharma@gmail.com",
"sumanfrenza@gmail.com",
"suman_172001@yahoo.com",
"sumit.dave@azistaspace.com",
"sumit0151989@gmail.com",
"sumit07libra@gmail.com",
"sumit_muk81@yahoo.com",
"sunil@azistaindustries.com",
"sunilbasate@gmail.com",
"sunilcharak@gmail.com",
"sunilgenxhiv@gmail.com",
"sunilkarna1975@gmail.com",
"sunilkarpe81@rediffmail.com",
"sunilp@heterohealthcare.com",
"suniltiwaridamarua@gmail.com",
"sunilunadkat@heterohealthcare.com",
"sunitgupta@heterohealthcare.com",
"sunnychawlapanipat@gmail.com",
"sureshbabu.n@heterohealthcare.com",
"sureshbabu@heterohealthcare.com",
"sureshmk.mk@gmail.com",
"survase147@gmail.com",
"suryaaaa@gmail.com",
"sushant.mali28@gmail.com",
"susheelgodara27@gmail.com",
"tabitha@heterohealthcare.com",
"tabrose12@gmail.com",
"talk2pranabkr@gmail.com",
"tausifshaikh972@gmail.com",
"tejasp166@gmail.com",
"thangsambi@gmail.com",
"thatsmeshiva@rediffmail.com",
"tiwari.alok031@gmail.com",
"tiwariamit08.2011@rediffmail.com",
"tiwari_vinod2@yahoo.com",
"umapathi.govindan@gmail.com",
"umeshgajbhare@gmail.com",
"umeshsvt@rediffmail.com",
"umesht45@gmail.com",
"uttamvaishnav1947@yahoo.co.in",
"vaibhav.khairnar@heterohealthcare.com",
"vaibhav01kanade@gmail.com",
"varsha.jain86@icloud.com",
"varunt@heterohealthcare.com",
"vasuaeran@gmail.com",
"veena@heterohealthcare.com",
"venkysmart01@yahoo.co.in",
"verma.rajesh225@gmail.com",
"vgp99@rediffmail.com",
"vidyasagar.akuthota@azistaindustries.com",
"vijay.chorghade@gmail.com",
"vijaychorghe01@gmail.com",
"vijaym396@gmail.com",
"vijay_07sheru@yahoo.co.in",
"vikas1979sachdeva@yahoo.co.in",
"vikasjainmittal@gmail.com",
"vik_jadhav77@yahoo.co.in",
"vilaspawale@yahoo.co.in",
"vinayaklawate@gmail.com",
"vineshpournami@gmail.com",
"vinodbhondave27@gmail.com",
"vinodcrema@gmail.com",
"vinodkanawade970@gmail.com",
"vipin.rathi@heterohealthcare.com",
"virender.gumber@gmail.com",
"vishal.pawar@heterohealthcare.com",
"vishal25chandel@gmail.com",
"vishalgulati171986@yahoo.com",
"vishwanathan.iyer@heterohealthcare.com",
"vithal.gangarde@heterohealthcare.com",
"vjygkp@rediffmail.com",
"volga.cheasm@heterohealthcare.com",
"volga.delasm@heterohealthcare.com",
"volga.jaiasm@heterohealthcare.com",
"volga.kolasm@heterohealthcare.com",
"waseem.khanday@gmail.com",
"yahiya_at@yahoo.com",
"yashsalvia@gmail.com",
"yjojireddy@heterohealthcare.com",
"yog.sabale@gmail.com",
"yogendra.dutt@heterohealthcare.com",
"yogendra.paliewal1986@gmail.com",
"yogeshpatil@heterohealthcare.com",
"yogi18487@gmail.com",
"zahid_27sd@yahoo.com"

		  ];
    function split( val ) {
      return val.split( /,\s*/ );
    }
    function extractLast( term ) {
      return split( term ).pop();
    }
 
    $( "#tags3" )
      // don't navigate away from the field on tab when selecting an item
      .on( "keydown", function( event ) {
        if ( event.keyCode === $.ui.keyCode.TAB &&
            $( this ).autocomplete( "instance" ).menu.active ) {
          event.preventDefault();
        }
      })
      .autocomplete({
        minLength: 0,
        source: function( request, response ) {
          // delegate back to autocomplete, but extract the last term
          response( $.ui.autocomplete.filter(
            availableTags, extractLast( request.term ) ) );
        },
        focus: function() {
          // prevent value inserted on focus
          return false;
        },
        select: function( event, ui ) {
          var terms = split( this.value );
          // remove the current input
          terms.pop();
          // add the selected item
          terms.push( ui.item.value );
          // add placeholder to get the comma-and-space at the end
          terms.push( "" );
          this.value = terms.join( "," );
          return false;
        }
      });
  } );
  </script> 
 <style>
.ui-autocomplete-input {
  border: none; 
  font-size: 14px;
  width:100%;
  height: 34px;
  margin-bottom: 5px;
  padding-top: 2px;
  border: 1px solid #DDD !important;
  padding-top: 0px !important;
  z-index: 1511;
  position: relative;
}
.ui-menu .ui-menu-item a {
  font-size: 12px;
  color:#0088cc;
}
.ui-autocomplete {
  position: absolute;
  top: 100%;
  left: 0;
  z-index: 1051 !important;
  float: left;
  display: none;
  min-width: 160px;
  _width: 160px;
  padding: 4px 0;
  margin: 2px 0 0 0;
  list-style:none;
  background-color: #ffffff;
  color:#0088cc;
  border-color: #ccc;
  border-color: rgba(0, 0, 0, 0.2);
  border-style: solid;
  border-width: 1px;
  -webkit-border-radius: 2px;
  -moz-border-radius: 2px;
  border-radius: 2px;
  -webkit-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
  -moz-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
  -webkit-background-clip: padding-box;
  -moz-background-clip: padding;
  background-clip: padding-box;
  *border-right-width: 2px;
  *border-bottom-width: 2px;
}
.ui-menu-item > a.ui-corner-all {
    display: block;
    padding: 3px 15px;
    clear: both;
    font-weight: normal;
    line-height: 18px;
    color: #0088cc;
    white-space: nowrap;
    text-decoration: none;
}
/* .ui-state-hover, .ui-state-active {
      color: #ffffff;
      text-decoration: none;
      background-color: #0088cc;
      border-radius: 0px;
      -webkit-border-radius: 0px;
      -moz-border-radius: 0px;
      background-image: none;
} */
.ui-state-hover,
.ui-widget-content .ui-state-hover,
.ui-widget-header .ui-state-hover,
.ui-state-focus,
.ui-widget-content .ui-state-focus,
.ui-widget-header .ui-state-focus {
	border: 1px solid #fbcb09;
	background: #fdf5ce url("images/ui-bg_glass_100_fdf5ce_1x400.png") 50% 50% repeat-x;
	font-weight: bold;
	color: #0088cc;
}
.ui-state-hover a,
.ui-state-hover a:hover,
.ui-state-hover a:link,
.ui-state-hover a:visited,
.ui-state-focus a,
.ui-state-focus a:hover,
.ui-state-focus a:link,
.ui-state-focus a:visited {
	color: #0088cc;
	text-decoration: none;
}
/* #modalIns{
    width: 500px;
} */
.select {
	border: 1px solid #E5E7E9;
	border-radius: 6px;
	height: 25px;
	padding: 2px;
	outline: none;
	color:#0088cc;
	margin-bottom:10px;
	
}

.panel-headingattn{
        height:50px;
		background-color:#0088cc;
		line-height:20px;
		color:#fff;
		padding-left:20px;
		padding-top:10px;
		
}
.btn1{
  display: inline-block;
  margin-bottom: 0;
  font-weight: normal;
  text-align: center;
  vertical-align: middle;
  touch-action: manipulation;
  cursor: pointer;
  background-image: none;
  border: 1px solid transparent;
  white-space: nowrap;
  padding: 3px 3px;
  font-size: 10px;
  line-height: 1.42857143;
  border-radius: 4px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  background-color:#fff;
  color:#0088cc;
}
.form-control1 {
    display: block;
    width: 100%;
    height: 20px;
    padding: 3px 6px;
    font-size: 10px;
    line-height: 1.42857143;
    color: #555555;
    background-color: #ffffff;
    background-image: none;
    border: 1px solid #cccccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
    -webkit-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
</style>

<script>
  function disableBackButton() {
	   window.history.forward();
	}
	setTimeout("disableBackButton()", 0);

 </script>
 <style>
 .modal {
}
.vertical-alignment-helper {
    display:table;
    height: 100%;
    width: 100%;
}
.vertical-align-center {
    /* To center vertically */
    display: table-cell;
    vertical-align: middle;
}
.modal-content {
    /* Bootstrap sets the size of the modal in the modal-dialog class, we need to inherit it */
    width:inherit;
    height:inherit;
    /* To center horizontally */
    margin: 0 auto;
}
</style>
<script>
  function disableBackButton() {
	   window.history.forward();
	}
	setTimeout("disableBackButton()", 0);


	document.onkeydown = function(){
	       if(event.keyCode == 116) {
	            event.returnValue = false;
	            event.keyCode = 0;
	            return false;
	        }

	}
	</script>

	<script type="text/javascript">
		window.history.forward();
		function noBack() { window.history.forward(); }
		
	
  </script>

	</head>
	<body  ng-app="myApp" id='pagebody' ng-controller="formCtrl"  onload="disableBackButton(); noBack();">
		<section class="body">

			<!-- start: header -->
			<header class="header">
				<div class="logo-container">
					<a href="#l" class="logo">
						<img src="assets/images/logo.png" height="35" alt="Hetero" />
					</a>
					<div class="visible-xs toggle-sidebar-left" data-toggle-class="sidebar-left-opened" data-target="html" data-fire-event="sidebar-left-opened">
						<i class="fa fa-bars" aria-label="Toggle sidebar"></i>
					</div>
				</div>
			
				<!-- start: search & user box -->
				<div class="header-right">
			
					<div id="userbox" class="userbox">
						<a href="#" data-toggle="dropdown">
							<div class="clear"></div>
							<div class="profile-info" data-lock-name="sairam" data-lock-email="sairam.d@heterohealthcare.com">
								<span class="name"><%=EMP_NAME %></span>
								
							</div>
			
							<i class="fa custom-caret"></i>
						</a>
			
						<div class="dropdown-menu">
							<ul class="list-unstyled">
								<li class="divider"></li>
								<!-- <li>
									<a role="menuitem" tabindex="-1" href="hhcl_changepassword.html"><i class="fa fa-cogs"></i>Change Password</a>
								</li> -->
								<li>
									<a role="menuitem" tabindex="-1" href="logout"><i class="fa fa-power-off"></i> Logout</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<!-- end: search & user box -->
			</header>
			<!-- end: header -->

			<div class="inner-wrapper">
				<!-- start: sidebar -->
				<aside id="sidebar-left" class="sidebar-left">
					<div class="nano">
						<div class="nano-content">
							<nav id="menu" class="nav-main" role="navigation">
								<ul class="nav nav-main">
									
									<li class="active">
									  <a href="User_Auth?Routing=DashBoard">
										<i class="fa fa-tachometer"></i>
										<span class="font-bold">Dashboard</span>
									  </a>
									</li>
									<li>
									  <a href="NewJoinees?Routing=MyProfile" >
										<i class="fa fa-user"></i>
										<span class="font-bold">Profile</span>
									  </a>
									</li>
									<li>
									  <a href="PayslipDownload">
										<i class="fa fa-download"></i>
										<span class="font-bold">Downloads</span>
									  </a>
									</li>
									<li>
									  <a href="hhcl_careers.jsp">
										<i class="fa fa-briefcase"></i>
										<span class="font-bold">Careers</span>
									  </a>
									</li>
									
									 <li style="display:<%=MGRFLAG_S%>;">
									  <a  href="ManagerApprovals?Routing=ManagerAppr" target="_parent">
										<i class="fa fa-check" ></i>
										<span class="font-bold">Manager Approvals</span>
									  </a>
									</li> 
									
									
									
									
									<li>
									  <a href="NewJoinees?Routing=DEPINFO">
										<i class="fa fa-users" ></i>
										<span class="font-bold">Department Information</span>
									  </a>
									</li>
									
									<li>
									  <a href="PayslipDownload?Routing=UPDATE" style="display:<%=HR_HRMS%>;"  >
										<i class="fa fa-user"></i>
										<span class="font-bold">HR/HRMS</span>
									  </a>
									 </li>  
									 
									<li style="display:<%=TDSFLAG%>;">
									  <a href="http://192.168.30.105:8080/IT/" target="_blank">
										<i class="fa fa-money "></i>
										<span class="font-bold">TDS Declaration</span>
									  </a>
									</li>
									
									<li>
									  <a href="http://www.heterohealthcare.com/" target="_blank">
										<i class="fa fa-building-o "></i>
										<span class="font-bold">About Our Organization</span>
									  </a>
									</li>
									
									<li>
										<!-- <div id="datepicker" class="calendar"></div> -->
									</li>
								</ul>
							</nav>
							
				
							
						</div>
				
					</div>
				
				</aside>
				<!-- end: sidebar -->

				<section role="main" class="content-body">
					<header class="page-header">
						
						<span style="padding-left:850px;"><b>Date:</b>
							<span>
								<script>
									var mydate=new Date()
									var year=mydate.getYear()
									if (year < 1000)
									year+=1900
									var day=mydate.getDay()
									var month=mydate.getMonth()
									var daym=mydate.getDate()
									if (daym<10)
									daym="0"+daym
									var dayarray=new Array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday")
									var montharray=new Array("January","February","March","April","May","June","July","August","September","October","November","December")
									document.write("<small><font color='#0088cc' face='Arial'><b>"+dayarray[day]+", "+montharray[month]+" "+daym+", "+year+"</b></font></small>")

								</script>
							</span>
						</span>
					</header>
					<!-- start: page  ng-selected="item.selected == true"  ng-change='myFunction(this.value);' -->
					 <!--  <select id="Month_Sel" >
					  <option  ng-repeat="(key, value) in Data_2" ng-click="key==9" value="{{key}}"> {{value}} </option>
					  </select> -->
					   &nbsp; &nbsp; &nbsp; 
					   
					    <div id='errMessage' align='center' style='color:red'>    </div>
						<div class="row" style="padding-left:50px;">
						  
						  
							<div class="col-xs-12 col-sm-6 col-md-11">
								<div class="panel panel-primary">
									<div class="panel-headingattn">
										<div class="col-md-4" style="margin-top:5px;">
										 <select class="select" id="Month_Sel" >
										    <option    value="currmonth"  selected > Current Month </option>
									  		<option  ng-repeat="(key, value) in Data_2"  value="{{key}}"  > {{value}} </option>
									  	</select>
									  	<!--  ng-selected="currmonth"
									  	 <select class="select"><option value="Monthwise">Month Wise</option><option value="Payperiod">Payroll Wise</option>
									  	 </select> -->
									  	&nbsp;&nbsp;&nbsp;
									  	<input type="checkbox" name="Payperiodwise" id="Payperiodwise" checked/>&nbsp;Payperiod&nbsp;
									  	
									  	
									 
									  	<button class="btn1"   ng-click="myFunction('My')">View</button>
									  	
									  	
 										
									  </div>
									    
									  	 
									  	
									  	<div class="col-md-6" style="margin-top:5px;">
									  	<span class="col-sm-1">From</span>
									  	<div class="col-sm-3">
									  	<input type="text" id="from_1" name="from"  readOnly class="form-control1">
									  	</div>
									  	<span class="col-sm-1">To</span>
									  	<div class="col-sm-3">
									  	<input type="text" id="to_1" name="to" readOnly class="form-control1">
									  	</div>
									  	<button class="btn1"  ng-click="myFunction('My_Datas')">View</button>
									  </div>
									  
									  <div class="col-md-2">
										<span><i class="fa fa-calendar fa-lg"></i>&nbsp;Attendance</span>
										</div>
										
										<!-- <button onclick="AttendanceRequest_Month();"> ClickAjex </button> &nbsp; <button ng-click="myFunction('My')">Click Me!</button> -->	
										
									</div>
									
									
									 <span align='center' id='image_scrl' style='display:none;'>
   										<img src="assets/images/spinner-blue1.gif" width='10%' height='10%' />
 										</span>
 										
 										
									<div class="panel-body" id="data_load" style='display:;'>
										<div class="col-md-12">
											<div class="table-responsive">
												<table class="table table-striped ">
													<thead class="thead-default " style="background-color:#f2f2f2; color:#777777;">
														<tr>
															
															<th class="text-center">Date</th>
															<th class="text-center">IN</th>
															<th class="text-center">OUT</th>
															<th class="text-center">Net Hours</th>
															<th style='display: none' class="text-center">+/- Hours</th>
															<th class="text-center">Deduction Hours</th>
															<th class="text-center">Day Type</th>
															<th class="text-center">Adjustments</th>
															<th class="text-center">Request Status</th>
															
														</tr>
													</thead>
											
						
						
													<tr ng-repeat="x in Data_1"  style="background-color:{{x.DEDCOLOR}}">
														<td class="text-center">{{ x.DATE }}</td>
														<td class="text-center">{{ x.FIN }}</td>
														<td class="text-center">{{ x.FOUT }}</td>
														<td class="text-center">{{ x.PERDAY }}</td>
														<td style='display: none' class="text-center" >{{ x.PLS }}</td>
														<td class="text-center" >{{ x.LESSHRS }}</td>
														<td class="text-center">{{ x.DAYTYPE }}</td>
														<td align="center"> 
														   <input type='button' class="btn btn-primary btn-sm"  name="{{ x.INNER }}" id="{{ x.DATE }}" data-toggle="modal" data-target="#myModal" id="myBtn" onclick="ICT_Req(this);" value='Request' style='display:{{ x.DAF }}'  > 
														</td> 
														<td class="text-center"> <span  id="{{ x.DATE }}_ST" > {{ x.DAREQ }}  </span> </td> 
													</tr>
													
													<tr>
													<td class="text-center">&nbsp;</td>
													<td class="text-center">&nbsp;</td>
													<td class="text-center">&nbsp;</td>
													<!-- <td class="text-center">&nbsp;</td> -->
													<td class="text-center"><b>Total</b></td>
													<td class="text-center"><b>{{Data_1[Data_1.length-1].DEDHOURS}} hrs.</b></td>
													<td style='display: none' class="text-center" colspan="2" style="color:red" align="center"><b>8 hrs. Will consider as One Leave</b></td>
													<td class="text-center">&nbsp;</td>
													
													
													</tr>
													
													
												</table>
											</div>
										</div>
									</div>
									
									
									
									
									       <span style='display:<%=FlexiPolicy_pdf%>'><b>Deduction Hours As per Policy Attached Here: 
                                            <a href="HHCL_HR_PLEXYTIME_INFO.html" target="_blank"><i class="fa fa-paperclip" style="font-size:28px;color:red" aria-hidden="true"></i></a>
                                            </b></span>
									
									
									
									
								</div>	
							</div>
						</div>
					
					
					<!-- end: page -->
					
				</section>
			

			
		</section>
		
		
		<!-- Model Box -->
		 <!--request Modal-->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="vertical-alignment-helper">
					  <div class="modal-dialog vertical-align-center" role="document">
						<div class="modal-content">
						  <div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							  <span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">Send Request</h4>
							<!-- Please Submit in between Payroll i.e., 26-previous Month-Current Year ------   27-Current Month-Current Year -->
						  </div>
							<div class="modal-body">
								<form action="ictrequestmail" method="post" >
									
									<!-- <div class="form-group">
									<label class="col-md-4 control-label">To</label>
									  <div class="col-sm-8">
									    <input type="text" class="form-control" name="to" id="to">
									  </div>
									</div>
									<div class="form-group">
									  <label class="col-md-4 control-label">CC</label>
									   <div class="col-sm-8">
									    <input type="text" class="form-control" name="cc" id="cc">
									  </div>
									</div> -->
									
									<div class="form-group">
									  <label class="col-md-4 control-label">Request Date</label>
									   <div class="col-sm-8">
									    <span id="Requ_Date"> </span>
									    
									    <input type="hidden" class="form-control" name="date" id="date"  readOnly>
									    
									     <input type="hidden" class="form-control" name="Requ_Date_Temp" id="Requ_Date_Temp"  >
									     
									    
									    
									    
									  </div>
									</div>
									
									<div class="form-group">
									  <label class="col-md-4 control-label">To &nbsp; (Reporting Manager)</label>
									   <div class="col-sm-8">
									   <a href="#" title='<%=EMAILDATA.get("MNGEMAIL")%>' > <%=EMAILDATA.get("MANAGERNAME")%>  </a>  
									    <span style="display:none;">
									     <input type="email" class="form-control addresspicker" name="toemail"  value='<%=EMAILDATA.get("MNGEMAIL")%>'  id="tags2"  placeholder="someone@example.com" >
									 </span>
									  </div>
									</div>
									
									
									<div class="form-group" style='display:none;'>
									  <label class="col-md-4 control-label">CC-Mail</label>
									   <div class="col-sm-8">
									     <input type="email" class="form-control addresspicker" name="ccemail"  id="tags3" value="" placeholder="someone@example.com" >
									  </div>
									</div>
									
									
									
									<div class="form-group">
									  <label class="col-md-4 control-label">Request Type</label>
									   <div class="col-sm-8">
									     <!-- <input type="text" class="form-control" name="Subject" id="Subject" value="Re: Incomplete Hours" > -->
									     
									      <select name="Subject" id="Subject" class="form-control">
									      <option value="Incomplete">Incomplete Hours</option>
									      <option value="Machineproblem">Machine Not Working</option>
									      <option value="Swipemiss">Forgot Swipe</option>
									     <!-- <option value="ODwork">On Duty Attendance Request</option> -->
										   <option value="On Duty Attendance Request">On Duty Attendance Request</option>
									      <option value="HODPermisssion">HOD Permission</option>
									      
									      </select>
									     
									     
									     
									  </div>
									</div>
									
									<div class="form-group">
										<label class="col-md-4 control-label">Request Message</label>
										<div class="col-md-8">
											<textarea class="form-control" rows="5" id="message" name="message"></textarea>
										</div>
									</div>
									
								

							</div>
							<div class="modal-footer">
							
							<span id="Responce_Message" style="color:red;" class="align-left"> </span>
							
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>&nbsp;
							<!-- <input type="button" id="Responce_Message_btn" style="display:" class="btn btn-primary" onclick="AttendanceRequest()" value="Send Request"/> -->
							
							<input type="button" id="Responce_Message_btn" style="display:" class="btn btn-primary"  tabindex="-1"  value="Send Request"/>
							
							
							
							</div>
							
						  </div>
						   </div>
						   
						    </div>
						   </div>
						   
		
		<!-- Model Box Ending -->
		<!-- Vendor -->
		
		<script src="assets/vendor/jquery-browser-mobile/jquery.browser.mobile.js"></script>
		<script src="assets/vendor/bootstrap/js/bootstrap.js"></script>
		<script src="assets/vendor/nanoscroller/nanoscroller.js"></script>
		<!-- <script src="assets/vendor/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
		 -->
		
		<!-- Specific Page Vendor -->
		<script src="assets/vendor/jquery-ui/js/jquery-ui-1.10.4.custom.js"></script>
		<script src="assets/vendor/jquery-ui-touch-punch/jquery.ui.touch-punch.js"></script>
		<script src="assets/vendor/jquery-appear/jquery.appear.js"></script>
		
		
		<!-- Theme Base, Components and Settings -->
		<script src="assets/javascripts/theme.js"></script>
		
		<!-- Theme Custom -->
		<script src="assets/javascripts/theme.custom.js"></script>
		
		<!-- Theme Initialization Files -->
		<script src="assets/javascripts/theme.init.js"></script>


		<!-- Examples -->
		<script src="assets/javascripts/dashboard/examples.dashboard.js"></script>
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.blockUI/2.70/jquery.blockUI.js"></script>
		
<script>

$('#Responce_Message_btn').keypress(function (event) {
    var code = event.keyCode || event.which;
   // alert(code);
  if(code==13){ 
	  $('#Responce_Message_btn').css('display','none');
	   AttendanceRequest();
  }else{
	  $('#Responce_Message').html("Invalid Key press,please press enter or click..!");
        event.preventDefault();
        return false;
        }
});

</script>
 <script>
$('#Responce_Message_btn').click(function () {
	 //var code = event.keyCode || event.which;
	  $('#Responce_Message').html(" ");
	  $('#Responce_Message_btn').css('display','none');
	    AttendanceRequest();
});

</script> 
	
	
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
   -->	
		<!-- <script>
$(document).ready(function(){
    $("#myBtn").click(function(){
        $("#myModal").modal();
    });
});
</script> -->

<!-- Modal -->

<div class="modal fade" id="myModalpop" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="vertical-alignment-helper">
<div class="modal-dialog vertical-align-center" role="document">
<div class="modal-content">
<!-- <div class="modal-header">
<button type="button" class="close" data-dismiss="modal" aria-label="Close">
  <span aria-hidden="true">&times;</span>
</button>

<h4 class="modal-title" id="myModalLabel">Send Request</h4> -->

<div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Server Response</h4>
        </div>
        <div class="modal-body">
          <B><p style='color:red;font-size:16' id='myModalpop_data'>
          
          Please wait your request is processing ..!
          
          </p></B>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
      
<!-- Please Submit in between Payroll i.e., 26-previous Month-Current Year ------   27-Current Month-Current Year -->
<!-- </div> -->
<!-- <div class="modal-body">
<span> hi welcome </span>
</div> -->
</div>
</div>
</div>
</div>

      
	</body>
</html>