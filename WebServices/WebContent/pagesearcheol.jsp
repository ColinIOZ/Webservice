<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
String id=(String)request.getParameter("id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Name search EOL</title>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/map.js"></script>
<script>
var id="<%=id%>";
$(function(){
	$.getJSON("pagesGetEOLData",
			{
				id:id
				
			},function(data)
			{
			if(data==null)
			{
				var content="<h4>在eol中查询的结果为null</h4>";
				$("#bhl_data").append(content);
				return;
			}
					$("#bhl_data").empty();
					var content="<h4>在eol中查询的结果如下：";
					$("#bhl_data").append(content);
					$("#bhl_data").append("<ul>");
					
					if(data.scientificName!=null&&data.scientificName.trim()!="")
					{
						$("#bhl_data").append("<b>Scientific Name</b>: "+data.scientificName+"<br>");
					}
					
					if(data.synonyms!=null)
					{
						var rs = "<table width='600px;'><tr><td><b>Synonyms</b>: </td><td><b>Synonym</b></td><td><b>Relationship</b></td></tr>";
						$.each(data.synonyms,function(i,obj){
							rs+="<tr><td></td><td>"+obj.synonym+"</td><td>"+obj.relationship+"</td></tr>";
							
						});
						rs+="</table>";
						$("#bhl_data").append(rs);
					}
					
					if(data.vernacularNames!=null)
					{
						var rs = "<table width='600px;'><tr><td><b>Vernacular Names</b>: </td><td><b>Vernacular Name</b></td><td><b>Language</b></td></tr>";
						$.each(data.vernacularNames,function(i,obj){
							rs+="<tr><td></td><td>"+obj.vernacularName+"</td><td>"+obj.language+"</td></tr>";
							
						});
						rs+="</table>";
						$("#bhl_data").append(rs);
					}
					
					if(data.references!=null)
					{
						var rs = "<table><tr><td><b>References</b>: </td><td></td></tr>";
						$.each(data.references,function(i,obj){
							rs+="<tr><td></td><td></td><td>"+obj+"</td></tr>";
						});
						rs+="</table>";
						$("#bhl_data").append(rs);
					}
					
					if(data.taxonConcepts!=null)
					{
						var rs = "<table width='1000px;'><tr><td><b>Taxon Concepts</b>: </td><td><b>Identifier</b></td><td><b>Scientific Name</b></td><td><b>According To</b></td></tr>";
						$.each(data.taxonConcepts,function(i,obj){
							rs+="<tr><td></td><td>"+obj.identifier+"</td><td>"+obj.scientificName+"</td><td>"+obj.nameAccordingTo+"</td></tr>";
							
						});
						rs+="</table>";
						$("#bhl_data").append(rs);
					}
					
					var rs =  "";
					var map = new Map();
					var list = new Array();
					var list0 = new Array(),list1= new Array(),list2= new Array(),list3= new Array(),list4= new Array(),list5= new Array(),
					list6= new Array(),list7= new Array(),list8= new Array(),list9= new Array(),list10= new Array(),list11= new Array(),
					list12= new Array(),list13= new Array(),list14= new Array(),list15= new Array(),
					list16= new Array(),list17= new Array(),list18= new Array(),list19= new Array(),list20= new Array(),list21= new Array(),
					list22= new Array(),list23= new Array(),list24= new Array(),list25= new Array(),list26= new Array(),list27= new Array(),
					list28= new Array(),list29= new Array(),list30= new Array(),list31= new Array(),list32= new Array(),
					list33= new Array(),list34= new Array(),list35= new Array(),list36= new Array(),list37= new Array(),list38= new Array(),
					list39= new Array(),list40= new Array(),list41= new Array(),list42= new Array(),list43= new Array(),list44= new Array(),
					list45= new Array(),list46= new Array(),list47= new Array(),list48= new Array(),list49= new Array(),
					list50= new Array(),list51= new Array(),list52= new Array();
					var map1 = new Map();
				//	for(var j = 0; j < 53; j++){
				//		"list"+j = new Array();
				//	}
					$.each(data.dataObjects,function(i,obj){
						
					    rs = showData(obj.title,obj.rightsHolder,obj.description,obj.dataType,obj.eolThumbnailURL,obj.eolMediaURL);
						if(obj.subject != null){
							if(obj.subject.indexOf("#Biology") != -1){
								list0.push("<font color='red'>*</font>"+rs);
								map.put("Biology",list0);
							}
							if(obj.subject.indexOf("#Description") != -1){
								list1.push("<font color='red'>*</font>"+rs);
								map.put("Description",list1);
								
							}
							if(obj.subject.indexOf("#Size") != -1){
								list2.push("<font color='red'>*</font>"+rs);
								map.put("Size",list2);
							}
							if(obj.subject.indexOf("#Cytology") != -1){
								list3.push("<font color='red'>*</font>"+rs);
								map.put("Cytology",list3);
							}
							if(obj.subject.indexOf("#Physiology") != -1){
								list4.push("<font color='red'>*</font>"+rs);
								map.put("Physiology",list4);
							}
							if(obj.subject.indexOf("#MolecularBiology") != -1){
								list5.push("<font color='red'>*</font>"+rs);
								map.put("MolecularBiology",list5);
							}
							if(obj.subject.indexOf("#Ecology") != -1){
								list6.push("<font color='red'>*</font>"+rs);
								map.put("Ecology",list6);
							}
							if(obj.subject.indexOf("#Conservation") != -1){
								list7.push("<font color='red'>*</font>"+rs);
								map.put("Conservation",list7);
							}
							if(obj.subject.indexOf("#Distribution") != -1){
								list8.push("<font color='red'>*</font>"+rs);
								map.put("Distribution",list8);
							}
							if(obj.subject.indexOf("#Use") != -1){
								list9.push("<font color='red'>*</font>"+rs);
								map.put("Use",list9);
							}
							if(obj.subject.indexOf("#Evolution") != -1){
								list10.push("<font color='red'>*</font>"+rs);
								map.put("Evolution",list10);
							}
							if(obj.subject.indexOf("#TaxonBiology") != -1){
								list11.push("<font color='red'>*</font>"+rs);
								map.put("TaxonBiology",list11);
							}
							if(obj.subject.indexOf("#TrophicStrategy") != -1){
								list12.push("<font color='red'>*</font>"+rs);
								map.put("TrophicStrategy",list12);
							}
							if(obj.subject.indexOf("#Cyclicity") != -1){
								list13.push("<font color='red'>*</font>"+rs);
								map.put("Cyclicity",list13);
							}
							if(obj.subject.indexOf("#Dispersal") != -1){
								list14.push("<font color='red'>*</font>"+rs);
								map.put("Dispersal",list14);
							}
							if(obj.subject.indexOf("#Migration") != -1){
								list15.push("<font color='red'>*</font>"+rs);
								map.put("Migration",list15);
							}
							if(obj.subject.indexOf("#LifeCycle") != -1){
								list16.push("<font color='red'>*</font>"+rs);
								map.put("LifeCycle",list16);
							}
							if(obj.subject.indexOf("#Reproduction") != -1){
								list17.push("<font color='red'>*</font>"+rs);
								map.put("Reproduction",list17);
							}
							if(obj.subject.indexOf("#Growth") != -1){
								list18.push("<font color='red'>*</font>"+rs);
								map.put("Growth",list18);
							}
							if(obj.subject.indexOf("#LifeExpectancy") != -1){
								list19.push("<font color='red'>*</font>"+rs);
								map.put("LifeExpectancy",list19);
							}
							if(obj.subject.indexOf("#Genetics") != -1){
								list20.push("<font color='red'>*</font>"+rs);
								map.put("Genetics",list20);
							}
							if(obj.subject.indexOf("#Associations") != -1){
								list21.push("<font color='red'>*</font>"+rs);
								map.put("Associations",list21);
							}
							if(obj.subject.indexOf("#Diseases") != -1){
								list22.push("<font color='red'>*</font>"+rs);
								map.put("Diseases",list22);
							}
							if(obj.subject.indexOf("#Habitat") != -1){
								list23.push("<font color='red'>*</font>"+rs);
								map.put("Habitat",list23);
							}
							if(obj.subject.indexOf("#Behaviour") != -1){
								list24.push("<font color='red'>*</font>"+rs);
								map.put("Behaviour",list24);
							}
							if(obj.subject.indexOf("#PopulationBiology") != -1){
								list25.push("<font color='red'>*</font>"+rs);
								map.put("PopulationBiology",list25);
							}
							if(obj.subject.indexOf("#GeneralDescription") != -1){
								list26.push("<font color='red'>*</font>"+rs);
								map.put("GeneralDescription",list26);
							}
							if(obj.subject.indexOf("#DiagnosticDescription") != -1){
								list27.push("<font color='red'>*</font>"+rs);
								map.put("DiagnosticDescription",list27);
							}
							if(obj.subject.indexOf("#LookAlikes") != -1){
								list28.push("<font color='red'>*</font>"+rs);
								map.put("LookAlikes",list28);
							}
							if(obj.subject.indexOf("#Key") != -1){
								list29.push("<font color='red'>*</font>"+rs);
								map.put("Key",list29);
							}
							if(obj.subject.indexOf("#Morphology") != -1){
								list30.push("<font color='red'>*</font>"+rs);
								map.put("Morphology",list30);
							}
							if(obj.subject.indexOf("#Management") != -1){
								list31.push("<font color='red'>*</font>"+rs);
								map.put("Management",list31);
							}
							if(obj.subject.indexOf("#ConservationStatus") != -1){
								list32.push("<font color='red'>*</font>"+rs);
								map.put("ConservationStatus",list32);
							}
							if(obj.subject.indexOf("#Legislation") != -1){
								list33.push("<font color='red'>*</font>"+rs);
								map.put("Legislation",list33);
							}
							if(obj.subject.indexOf("#Threats") != -1){
								list34.push("<font color='red'>*</font>"+rs);
								map.put("Threats",list34);
							}
							if(obj.subject.indexOf("#Trends") != -1){
								list35.push("<font color='red'>*</font>"+rs);
								map.put("Trends",list35);
							}
							if(obj.subject.indexOf("#Procedures") != -1){
								list36.push("<font color='red'>*</font>"+rs);
								map.put("Procedures",list36);
							}
							if(obj.subject.indexOf("#RiskStatement") != -1){
								list37.push("<font color='red'>*</font>"+rs);
								map.put("RiskStatement",list37);
							}
							
							
							//eol
							if(obj.subject.indexOf("#Barcode") != -1){
								list38.push("<font color='red'>*</font>"+rs);
								map.put("Barcode",list38);
							}
							if(obj.subject.indexOf("#CitizenScience") != -1){
								list39.push("<font color='red'>*</font>"+rs);
								map.put("CitizenScience",list39);
							}
							if(obj.subject.indexOf("#Development") != -1){
								list40.push("<font color='red'>*</font>"+rs);
								map.put("Development",list40);
							}
							if(obj.subject.indexOf("#Education") != -1){
								list41.push("<font color='red'>*</font>"+rs);
								map.put("Education",list41);
							}
							if(obj.subject.indexOf("#EducationResources") != -1){
								list42.push("<font color='red'>*</font>"+rs);
								map.put("EducationResources",list42);
							}
							if(obj.subject.indexOf("#FossilHistory") != -1){
								list43.push("<font color='red'>*</font>"+rs);
								map.put("FossilHistory",list43);
							}
							if(obj.subject.indexOf("#FunctionalAdaptations") != -1){
								list44.push("<font color='red'>*</font>"+rs);
								map.put("FunctionalAdaptations",list44);
							}
							if(obj.subject.indexOf("#Genome") != -1){
								list45.push("<font color='red'>*</font>"+rs);
								map.put("Genome",list45);
							}
							if(obj.subject.indexOf("#IdentificationResources") != -1){
								list46.push("<font color='red'>*</font>"+rs);
								map.put("IdentificationResources",list46);
							}
							if(obj.subject.indexOf("#Notes") != -1){
								list47.push("<font color='red'>*</font>"+rs);
								map.put("Notes",list47);
							}
							if(obj.subject.indexOf("#NucleotideSequences") != -1){
								list48.push("<font color='red'>*</font>"+rs);
								map.put("NucleotideSequences",list48);
							}
							if(obj.subject.indexOf("#SystematicsOrPhylogenetics") != -1){
								list49.push("<font color='red'>*</font>"+rs);
								map.put("SystematicsOrPhylogenetics",list49);
							}
							if(obj.subject.indexOf("#Taxonomy") != -1){
								list50.push("<font color='red'>*</font>"+rs);
								map.put("Taxonomy",list50);
							}
							if(obj.subject.indexOf("#TypeInformation") != -1){
								list51.push("<font color='red'>*</font>"+rs);
								map.put("TypeInformation",list51);
							}
							
							
						}else{
							list52.push("<font color='red'>*</font>"+rs);
							map.put("多媒体",list52);
							
						}
					});
					
					var show_rs = "";
					$.each(map,function(key,values){
						if(key != "put" && key != "get" && key != "remove" && key != "keyset"){
							
							show_rs += "<h4><font color='red'>"+key.substring(0,key.length-1)+"</font></h4><br>";
							$(values).each(function(){
								show_rs += this;
							});
						}
					});
					
					var li="<li>"+show_rs+"</li>";
					$("#bhl_data").append(li);
					
					$("#bhl_data").append("</ul>");
				
			});
});
function showData(title,rightsHolder,description,dataType,eolThumbnailURL,eolMediaURL){
	var rs_data = "";
	if(title!=null && title.trim()!="")
	{
		rs_data+= "<b>"+title+":</b><br>";
	}
	if(rightsHolder!=null && rightsHolder.trim()!="")
	{
		rs_data+="<b>Rights Holder</b>:"+rightsHolder+"<br>";
	}
	if(description!=null && description.trim()!="")
	{
		rs_data+= description+"<br>";
	}
	if(dataType.indexOf("Image") != -1)
	{
		rs_data+= "<a href='"+(typeof(eolMediaURL)=='undefined'?'javascript:void(0)':eolMediaURL)+"'><image src='"+eolThumbnailURL+"'/></a><br>";
	}
	if(dataType.indexOf("Sound") != -1)
	{
		rs_data+= "<embed src='"+eolMediaURL+"' autostart='false' loop='false' height=20/><br>";
	}
	return rs_data;
}



</script>
</head>
<body>
<div id="bhl_data"></div>
</body>
</html>