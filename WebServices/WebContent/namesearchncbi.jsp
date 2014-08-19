<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 
String scientificName=request.getParameter("scientificName");
String retstart=request.getParameter("retstart");
String db=request.getParameter("db");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Name search NCBI</title>

<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script>
var scientificName="<%=scientificName%>";
var retstart="<%=retstart%>";
var db="<%=db%>";
$(function(){
	$.getJSON("nameGetNCBIData",
			{
				scientificName:scientificName,
				retstart:retstart,
				db:db
			},function(data)
			{
				$("#rs_data").append("搜索结果为：<font color='red'>"+data.count+" </font>条<br><br>");
				
				var rs = "";
				if(db == "pubmed"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td><td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"'>"+obj.title+"</a><br>";
							$.each(obj.authors,function(n,author){
								rs += author.name+",";
							});
							rs = rs.substring(0,rs.length-1)+"<br>";
							rs += obj.source+(obj.epubdate==""?"."+obj.pubdate:"."+obj.epubdate)+(obj.elocationid==""?'':"."+obj.elocationid)+(obj.volume==""?'':";"+obj.volume)+(obj.issue==""?'':"("+obj.issue+")")+(obj.pages==""?'':obj.pages)+".<br>";
							rs += "<font color='silver'>PMID:"+obj.uid+"["+obj.recordstatus+"]</font><br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/"+db+"?linkname="+db+"_"+db+"&from_uid="+obj.uid+"'>Related citations</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "protein" || db == "nuccore" || db == "nucleotide"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td><td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"'>"+obj.title+"</a><br>";
							rs += obj.slen+"&nbsp;"+obj.moltype+"&nbsp;protein<br>";
							rs += "<font color='silver'>Accession:"+obj.caption+"&nbsp;&nbsp;GI:"+obj.gi+"</font><br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"?report=genpept'>GenPept</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"?report=fasta'>FASTA</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"?report=graph'>Graphics</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/"+db+"?LinkName="+db+"_"+db+"&from_uid="+obj.uid+"'>Related Sequences</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/"+db+"?LinkName="+db+"_"+db+"_identical"+"&from_uid="+obj.uid+"'>Identical Proteins</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "nucgss"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td><td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.accessionversion+"'>"+obj.title+"</a><br>";
							rs += obj.slen+" bp "+obj.topology+"&nbsp;"+obj.moltype.toUpperCase() +"<br>";
							rs += "<font color='silver'>Accession:"+obj.caption+"&nbsp;&nbsp;GI:"+obj.gi+"</font><br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/nucgss/"+obj.uid+"?report=est'>GSS</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/nucgss/"+obj.uid+"?report=genbank'>GenBank</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/nucgss/"+obj.uid+"?report=fasta'>FASTA</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "nucest"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td><td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.accessionversion+"'>"+obj.title+"</a><br>";
							rs += obj.slen+" bp "+obj.topology+"&nbsp;"+obj.biomol+"<br>";
							rs += "<font color='silver'>Accession:"+obj.caption+"&nbsp;&nbsp;GI:"+obj.gi+"</font><br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/nucest/"+obj.uid+"?report=est'>EST</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/nucest/"+obj.uid+"?report=genbank'>GenBank</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/nucest/"+obj.uid+"?report=fasta'>FASTA</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "structure"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td>";
							rs +="<td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/mmdb/mmdbsrv.cgi?uid="+obj.uid+"'><img src=''/></a></td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/mmdb/mmdbsrv.cgi?uid="+obj.uid+"'>"+obj.pdbdescr+"["+obj.pdbclass+"]</a><br>";
							rs += "Taxonomy: <b>"+scientificName+"</b><br>";
							rs += "Proteins:"+obj.proteinmoleculecount+"&nbsp;&nbsp;modified: "+obj.mmdbmodifydate+"<br>";
							rs += "<font color='silver'>MMDB ID:"+obj.uid+"&nbsp;&nbsp;PDB ID:"+obj.pdbacc+"</font><br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/"+db+"/mmdb/mmdb_strview.cgi/mmdb.cn3?program=cn3d&display=0&complexity=3&buidx=1&uid="+obj.uid+"'>View in Cn3D</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/"+db+"/vastplus/vastplus.cgi?uid="+obj.uid+"?report=fasta'>Similar Structures</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pubmed?LinkName="+db+"_pubmed&from_uid="+obj.uid+"'>PubMed</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/protein?LinkName="+db+"_protein&from_uid="+obj.uid+"'>Protein</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/cdd?LinkName="+db+"_cdd&from_uid="+obj.uid+"'>Conserved Domains</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "genome"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td>";
							rs += "<td>"+obj.organism_name+"<br>";
							rs += obj.defline+"<br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "assembly"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.lastmajorreleaseaccession+"'>"+obj.assemblyname+"</a><br>";
							rs += "Organism: <b>"+obj.organism+"</b><br>";
							rs += "Infraspecific name:"+obj.biosource.infraspecieslist[0].sub_type+":"+obj.biosource.infraspecieslist[0].sub_value+"</b><br>";
							rs += "Submitter: "+obj.submitterorganization+"<br>";
							rs += "Date: "+obj.submissiondate+"<br>";
							rs += "Assembly level:"+obj.assemblystatus+"<br>";
							rs += "Genome representation:"+"<br>";
							rs += "Representative status:"+obj.refseq_category+"<br>";
							rs += "GenBank Assembly ID:"+obj.synonym.genbank+"(latest)<br>";
							rs += "RefSeq Assembly ID:"+obj.synonym.refseq+"(latest)<br>";
							rs += "<font color='silver'>IDs:"+obj.uid+"[uid]"+obj.gbuid+"[GenBank]"+obj.rsuid+"[RefSeq]</font><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "bioproject"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"'>"+obj.project_name+"</a><br>";
							rs += obj.project_title+"<br>";
							rs += "Taxonomy:<a href='http://www.ncbi.nlm.nih.gov/taxonomy/"+obj.taxid+"'>"+obj.project_name+"</a><br>";
							rs += "Project data type: "+obj.project_data_type+"(latest)<br>";
							rs += "Attributes : Scope:"+obj.project_target_scope+"; Material:"+obj.project_target_material+"; Capture:"+obj.project_target_capture+"; Method Type:"+obj.project_methodtype+"<br>";
							rs += obj.submitter_organization+"<br>";
							rs += "<font color='silver'>Accession:"+obj.project_acc+"&nbsp;&nbsp;ID:"+obj.uid+"</font><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "biosample"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"'>"+obj.title+"</a><br>";
							rs += obj.sourcesample+"; Sample name: "+obj.accession+"<br>";
							rs += "<font color='silver'>ID: "+obj.uid+"<br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/"+db+"?LinkName="+"biosample_"+db+"&from_uid="+obj.uid+"'>BioProject</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/sra?LinkName=biosample_sra&from_uid="+obj.uid+"'>SRA</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/nuccore?LinkName=biosample_nuccore&from_uid="+obj.uid+"'>Nucleotide</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/gds?LinkName="+"biosample_gds&from_uid="+obj.uid+"'>GEO DataSets</a><br><br>";
							//rs += obj.sampledata+"<br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "blastdbinfo"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"'>"+obj.title+"</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "gapplus"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"'>"+obj.publication.title+"</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "orgtrack"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"'>"+obj.title+"</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "gtr"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"'>"+obj.testname+"</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "books"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td>";
							rs += "<tr><td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.bookaccessionid+"'><img src=''/></a></td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.bookaccessionid+"'>"+obj.title+"</a><br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.accessionid+"'>Top results in this book</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.accessionid+"'>Table of Contents</a><br><br>";
							//rs += obj.bookinfo+"<br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "cdd"){
					rs += "<table align='center'>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td  valign='top'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"'>"+obj.organism+"</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "clone"){
					rs += "<table align='center' style='border-collapse:collapse;'>";
					rs += "<tr style='border:1px solid #eee;' bgcolor='silver'><td></td><td>Clone Name</td><td>Clone Name Aliases</td><td>Library Name</td><td>Library Abbreviation</td><td>Library Type</td><td>Organism</td><td>Vector Type</td><td>Placed</td></tr>";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td width='100px;'><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"'>"+obj.clname+"</a></td>";
							rs += "<td width='100px;'></td>";
							rs += "<td width='250px;'><a href='http://www.ncbi.nlm.nih.gov/"+db+"/library/genomic/"+obj.uid+"'>"+obj.libname+"</a></td>";
							rs += "<td width='150px;'>"+obj.libabbr+"</td>";
							rs += "<td width='100px;'>"+obj.libtype+"</td>";
							rs += "<td width='150px;'>"+obj.organism+"</td>";
							rs += "<td width='100px;'>"+obj.vecttypelist[0]+"</td>";
							rs += "<td width='50px;'>"+obj.placed+"</td>";
							num++;
						}
						rs += "</tr>";
					});
					rs += "</table>";
				}
				if(db == "gap"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							if(obj.d_object_type == "study"){
								rs += "<td>Study: <a href='http://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id="+obj.d_study_results.d_study_id+"'><b>"+obj.d_study_results.d_study_name+"</b></a><br>";
								rs += "Embargo Release: "+obj.d_study_results.d_study_embargo_date+"<br>";
								rs += " Details  : "+"<br>";
								rs += " Participants  : "+obj.d_study_results.d_num_participants_in_subtree+"<br>";
								rs += " Type Of Study  : "+obj.d_study_results.d_study_type+"<br>";
								rs += " Links  : <a href=''>links</a><br>";
								rs += " Platform  : <br><br>";
							}
							if(obj.d_object_type == "variable"){
								rs += "<td>Clinical Variable: <a href='http://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id="+obj.d_variable_results.d_variable_id+"'><b>"+obj.d_variable_results.d_variable_name+"</b></a><br><br>";
								rs += "Dataset: <a href='http://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/dataset.cgi?study_id="+obj.d_variable_results.d_variable_id+"'>"+obj.d_variable_results.d_variable_dataset.d_variable_dataset_name+"</a><br>";
								rs += obj.d_variable_results.d_variable_dataset.d_variable_dataset_description+"<br>";
								rs += "Variable Description: "+obj.d_variable_results.d_variable_description+"<br>";
								rs += "Variable ID: "+obj.d_variable_results.d_variable_id+"<br><br>";
							}
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				
				if(db == "gene"){
					rs += "<table align='center' width='1000px;' style='border-collapse:collapse;'>";
					rs += "<tr style='border:1px solid #eee;' bgcolor='silver'>";
					rs += "<td width='150px;'>Name/Gene ID</td>";
					rs += "<td width='350px;'>Description</td>";
					rs += "<td width='350px;'>Location</td>";
					rs += "<td width='150px;'>Aliases</td></tr>";
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td><a href='http://www.ncbi.nlm.nih.gov/"+db+"/"+obj.uid+"'>"+obj.name+"</a><br>ID："+obj.uid+"</td>";
							rs += "<td>"+obj.description+"["+obj.organism.scientificname+"("+obj.organism.commonname+")]</td>";
							rs += "<td>Chromosome "+obj.chromosome+","+(obj.genomicinfo[0]==null?'':obj.genomicinfo[0].chraccver)+"("+(obj.genomicinfo[0]==null?'':obj.genomicinfo[0].chrstart)+".."+(obj.genomicinfo[0]==null?'':obj.genomicinfo[0].chrstop)+")</td>";
							rs += "<td>"+obj.otheraliases+"</td></tr>";
							rs += "<tr height='15px;'></tr>";
						}
						
					});
					rs += "</table>";
				}
				if(db == "gds"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc="+obj.accession+"'>"+obj.title+"</a><br>";
							rs += obj.summary+"<br>";
							rs += "Organism: &nbsp;&nbsp;<b>"+obj.taxon+"</b><br>";
							rs += "Type:&nbsp;&nbsp;"+obj.gdstype+"<br>";
							rs += "Platform:<a href='http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc="+obj.accession+"'>GPL"+obj.gpl+"</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/gds/?term="+obj.accession+"[ACCN] AND gsm[ETYP]'>"+obj.n_samples+"Samples</a><br>";
							rs += "Download data:<a href='http://www.ncbi.nlm.nih.gov/gds/download/?acc="+obj.accession+"'>GEO("+obj.suppfile+")</a>";
							if(obj.extrelations[0]!=null){
								rs += "&nbsp;,&nbsp;<a href='http://www.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/"+obj.extrelations[0].targetobject.substring(0,6)+"/"+obj.extrelations[0].targetobject+"'>SRA&nbsp;"+obj.extrelations[0].targetobject+"</a><br>";
							}else{
								rs += "<br>";
							}
							rs += "<font color='silver'>Series &nbsp; Accession: &nbsp;&nbsp;GSE"+obj.gse+"&nbsp;&nbsp;ID:"+obj.uid+"</font><br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pubmed?LinkName=gds_pubmed&from_uid="+obj.uid+"'>PubMed</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pmc?LinkName=gds_pmc&from_uid="+obj.uid+"'>Full text in PMC</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/gds?LinkName=gds_gds_similar&from_uid="+obj.uid+"'>Full text in PMC</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "medgen"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/medgen/"+obj.uid+"'>"+obj.title+"</a><br>";
							rs += "<font color='silver'>MedGen UID:"+obj.uid+"&nbsp;&nbsp;•&nbsp;Concept ID:"+obj.conceptid+"&nbsp;&nbsp;•&nbsp;"+obj.semantictype;
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "journals" ){
					rs += "esummary error";
				}
				if(db == "genomeprj" || db == "toolkitall" ){
					rs += "esearch error";
				}
				if(db == "mesh"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/mesh/"+obj.uid+"'>"+obj.ds_meshterms[0]+"</a><br>";
							rs += obj.ds_scopenote+"<br>";
							rs += "Date introduced: "+obj.ds_entrydate+"<br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "ncbisearch"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='"+obj.url+"'>"+obj.title+"</a><br>";
							rs += (obj.description==null?'No description available':obj.description)+"<br>";
							rs += "<font color='silver'>"+obj.url+"</font><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "nlmcatalog"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/nlmcatalog/"+obj.uid+"'>"+obj.titlemainlist[0].title+"</a><br>";
							$.each(obj.authorlist,function(n,author){
								
								rs += author.lastname+","+author.forename+";&nbsp;";
							});
							rs = rs.substring(0,rs.length-1);
							rs += ".<br>";
							rs += obj.publicationinfolist[0].imprint+"<br>";
							rs += "<font color='silver'>NLM ID: "+obj.uid+"["+obj.resourceinfolist[0].typeofresource+"]</font><br><br>";
							
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "pmc"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/pmc/articles/"+(obj.articleids[2]==null?'':obj.articleids[2].value)+"'>"+obj.title+"</a><br>";
							$.each(obj.authors,function(n,author){
								
								rs += author.name+",&nbsp;";
							});
							rs = rs.substring(0,rs.length-1);
							rs += "<br>";
							rs += obj.source+"."+(obj.pubdate==null?obj.epubdate:obj.pubdate)+";&nbsp;"+obj.volume+"("+obj.issue+"):"+obj.pages+".&nbsp; Published online &nbsp;"+obj.sortdate+"&nbsp;"+obj.articleids[1]+"<br>";
							rs += "<font color='silver'>PMCID:"+(obj.articleids[2]==null?'':obj.articleids[2].value)+"</font><br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pmc/articles/"+(obj.articleids[2]==null?'':obj.articleids[2].value)+"/?report=classic'>Full text in PMC</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pmc/articles/"+(obj.articleids[2]==null?'':obj.articleids[2].value)+"/?report=reader'>Full text in PMC</a>&nbsp;&nbsp;";
							var pdfname = obj.articleids[1].value;
							pdfname = pdfname.substring(pdfname.indexOf('/')+1);
							pdfname = pdfname.replace('.','-');
							pdfname = pdfname.replace('.','-');
							//alert(pdfname);
							//var a="a,b,c,d,e,f,g";	var b=a.replace(new RegExp(/(,)/g),'.');	alert(b);
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pmc/articles/"+(obj.articleids[2]==null?'':obj.articleids[2].value)+"/pdf/"+pdfname+".pdf'>Full text in PMC</a><br><br>";

							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "popset"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/popset/"+obj.uid+"'>"+obj.title+"</a><br>";
							rs += obj.settype+",&nbsp;&nbsp;"+obj.statistics[obj.statistics.length-1].count+"&nbsp;sequences<br>";
							rs += "<font color='silver'>UID: "+obj.uid+"</font><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "probe"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/probe/"+obj.uid+"'>"+obj.title+"</a><br>";
							rs += "<font color='silver'>Accession:"+obj.probeacc+"&nbsp;&nbsp;ID:"+obj.uid+"</font><br>";
							rs += "<b>Name:</b>"+obj.name+"<br>";
							rs += "<b>Type:</b>"+obj.ptype+"<br>";
							rs += "<b>Application:</b>"+obj.applications[0]+"<br>";
							rs += "<b>Source organisms:</b><a href='http://www.ncbi.nlm.nih.gov/taxonomy/"+(obj.source[1]==null?'':obj.source[1].tag)+"'>"+(obj.source[1]==null?'':obj.source[1].name)+"</a>;&nbsp;<a href='http://www.ncbi.nlm.nih.gov/taxonomy/"+(obj.source[2]==null?'':obj.source[2].tag)+"'>"+(obj.source[2]==null?'':obj.source[2].name)+"</a><br>";
							rs += "<b>Source sequence:</b><a href='http://www.ncbi.nlm.nih.gov/nucleotide/"+(obj.source[3]==null?'':obj.source[3].tag)+"'>"+(obj.source[3]==null?'':obj.source[3].tag)+"</a><br>";
							rs += "<b>Source gene:</b><a href='http://www.ncbi.nlm.nih.gov/gene/"+(obj.source[0]==null?'':obj.source[0].tag)+"'>"+(obj.source[0]==null?'':obj.source[0].name)+"</a><br>";
							rs += "<b>Target organisms:</b><a href='http://www.ncbi.nlm.nih.gov/taxonomy/"+(obj.target[1]==null?'':obj.target[1].tag)+"'>"+(obj.target[1]==null?'':obj.target[1].name)+"</a>;&nbsp;<a href='http://www.ncbi.nlm.nih.gov/taxonomy/"+(obj.target[2]==null?'':obj.target[2].tag)+"'>"+(obj.target[1]==null?'':obj.target[2].name)+"</a><br>";
							rs += "<b>Target sequence:</b><a href='http://www.ncbi.nlm.nih.gov/nucleotide/"+(obj.target[3]==null?'':obj.target[3].tag)+"'>"+(obj.target[3]==null?'':obj.target[3].tag)+"</a><br>";
							rs += "<b>Target gene:</b><a href='http://www.ncbi.nlm.nih.gov/gene/"+(obj.target[0]==null?'':obj.target[0].tag)+"'>"+(obj.target[0]==null?'':obj.target[0].name)+"</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "proteinclusters"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/proteinclusters/"+obj.uid+"'>"+obj.definition+"</a><br>";
							rs += "Source:"+obj.source+"<br>";
							rs += "Conserved in: "+obj.commontaxonomy+"<br>";
							rs += "Proteins: "+obj.total_prots+"<br>";
							rs += "<font color='silver'>Accession:"+obj.accn+"&nbsp;&nbsp;ID:"+obj.uid+"</font><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "pcassay"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://pubchem.ncbi.nlm.nih.gov/assay/assay.cgi?aid="+obj.aid+"&loc=ea_ras'>"+obj.assayname+"</a><br>";
							rs += "Source:"+obj.currentsourcename+"<br>";
							rs += "Protein Target: "+(obj.proteintargetlist[0]==null?'':obj.proteintargetlist[0].name)+"<br>";
							rs += "Assay data:";
							rs += "<a href='http://pubchem.ncbi.nlm.nih.gov/assay/asis.cgi?q=r&aid='"+obj.aid+"&activity"+obj.aid+"=active'>"+obj.activecidcount+"&nbsp;Active</a>&nbsp;&nbsp;";
							rs += "<a href='http://pubchem.ncbi.nlm.nih.gov/assay/asis.cgi?q=r&aid='"+obj.aid+"&ac=1'>"+obj.numberofcidswithactivityconcmicromolar+"&nbsp;Activity ≤ 1 µM</a>&nbsp;&nbsp;";
							rs += "<a href='http://pubchem.ncbi.nlm.nih.gov/assay/asis.cgi?q=r&aid='"+obj.aid+"'>"+obj.totalcidcount+"&nbsp;Tested</a><br>";
							rs += "<font color='silver'>AID:"+obj.aid+"</font><br>";
							rs += "<a href='http://pubchem.ncbi.nlm.nih.gov/assay/assay.cgi?aid="+obj.aid+"'>Summary</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pccompound?LinkName=pcassay_pccompound_active&from_uid="+obj.uid+"'>Compounds, Active</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pccompound?LinkName=pcassay_pccompound_activityconcmicromolar&from_uid="+obj.uid+"'>Compounds, activity ≤ 1 µM</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pubmed?LinkName=pcassay_pubmed&from_uid="+obj.uid+"'>PubMed Citation</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pacssay?LinkName=pcassay_pacssay_pccompound_targetneighbor_list&from_uid="+obj.uid+"'>Related BioAssays by Depositor</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pacssay?LinkName=pcassay_pacssay_pccompound_targetneighbor_list&from_uid="+obj.uid+"'>Related BioAssays by Target</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "biosystems"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/biosystems/"+obj.uid+"'>"+obj.biosystem.biosystemname+"</a><br>";
							rs += "Type: "+obj.biosystem.bstype+"&nbsp;&nbsp;";
							rs += "Taxonomic scope: "+obj.biosystem.bscategory+"&nbsp;&nbsp;";
							rs += "Organism:"+(obj.taxonomy==null?'':obj.taxonomy[0].taxonomyname)+"<br>";
							rs += "<font color='silver'>BSID:"+obj.uid+"</font>&nbsp;&nbsp;&nbsp;&nbsp;";
							rs += "<a href='http://www.kegg.jp/'>KEGG:</a>&nbsp;<a href='http://www.kegg.jp/pathway/"+obj.biosystem.externalid+"'>"+obj.biosystem.externalid+" </a><br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/protein?linkname=biosystems_protein&from_uid="+obj.uid+"'>Proteins</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/gene?linkname=biosystems_gene&from_uid="+obj.uid+"'>Genes</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pccompound?linkname=biosystems_pccompound&from_uid="+obj.uid+"'> Compounds</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pubmed?linkname=biosystems_pubmed&from_uid="+obj.uid+"'>PubMed Citation</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "pccompound"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?cid="+obj.cid+"&loc=ec_rcs'><img src=''/></a></td>";
							rs += "<td><a href='http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?cid="+obj.cid+"&loc=ec_rcs'>"+obj.synonymlist[0]+";"+obj.synonymlist[1]+";"+obj.synonymlist[2]+"...</a><br>";
							rs += "MW:"+obj.molecularweight+"&nbsp;g/mol&nbsp;&nbsp;MF: "+obj.molecularformula+"<br>";
							rs += "<font color='silver'>CID: "+obj.cid;
							if(obj.iupacname == null || obj.iupacname == ""){
								rs += "<br>";
							}else{
								rs += "<br>IUPAC name:"+obj.iupacname.substring(0,60)+"...<br>";
							}
							rs += "</font>";
							rs += "<a href='http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?cid="+obj.cid+"'>Summary</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pccompound?LinkName=pccompound_pccompound&from_uid="+obj.uid+"'>Similar Compounds</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pccompound?LinkName=pccompound_pccompound_parent_connectivity_pulldown&from_uid="+obj.uid+"'> Same Parent, Connectivity</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pubmed?LinkName=pccompound_pubmed_mesh&from_uid="+obj.uid+"'>PubMed (MeSH Keyword)</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "pcsubstance"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid="+obj.sid+"&loc=es_rss'><img src=''/></a></td>";
							rs += "<td><a href='http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid="+obj.sid+"&loc=es_rss'>"+obj.synonymlist[0]+";"+obj.synonymlist[1]+";"+obj.synonymlist[2]+"...</a><br>";
							rs += "Source: <a href='"+obj.dburl+"'>"+obj.currentsourcename+"("+obj.sourceid+")"+"</a><br>";
							rs += "<font color='silver'>SID: "+obj.sid;
							if(obj.compoundidlist == null || typeof(obj.compoundidlist[0])=='undefined'){
								rs += "<br>";
							}else{
								rs += "&nbsp;&nbsp;";
								var rstemp = "[CID:";
								$.each(obj.compoundidlist,function(n,c){
									rstemp += c+",";
								});
								rstemp = rstemp.substring(0,rstemp.length-1)+"]";
								rs += rstemp+"<br>";
								                   
							}
							rs += "</font>";
							rs += "<a href='http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?sid="+obj.sid+"'>Summary</a>&nbsp;&nbsp;";
							rs += "<a href='http://pubchem.ncbi.nlm.nih.gov/summary/summary.cgi?cid="+obj.cid+"'>PubChem Same Compound</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pcsubstance?LinkName=pcsubstance_pcsubstance_parent_connectivity_pulldo&from_uid="+obj.uid+"'>Same Parent, Connectivity</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pubmed?LinkName=pcsubstance_pubmed_mesh&from_uid="+obj.uid+"'>PubMed (MeSH Keyword)</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "pubmedhealth"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/pubmedhealth/"+obj.accessionid+"'>"+obj.title+"</a><br>";
							if(obj.teaser != ""){
								rs += obj.teaser+"<br>";
							}
							if(obj.byline != ""){
								rs += obj.byline+"<br>";
							}
							if(obj.updatedate.indexOf("Version")){
								rs += "<font color='silver'>Version:&nbsp;&nbsp;"+obj.updatedate +"</font><br><br>";
							}else{
								
								rs += "<font color='silver'>"+obj.updatedate +"</font><br><br>";
							}
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "snp"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/projects/SNP/snp_ref.cgi?rs="+obj.uid+"'>rs"+obj.uid+"</a>["+scientificName+"]<br>";
							rs += obj.docsum.substring(4,obj.docsum.length)+"<br>";
							rs += "Validated:&nbsp;&nbsp;"+obj.validated+"<br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "sra"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/sra/SRX648553[accn]'>"+obj.uid+"</a><br>";
							rs += obj.expxml+"<br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "taxonomy"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id="+obj.uid+"'>"+obj.scientificname+"</a><br>";
							rs += "("+obj.commonname+"),&nbsp;&nbsp;"+obj.rank+",&nbsp;&nbsp;"+obj.division+"<br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/nucleotide?term=txid"+obj.taxid+"[Organism]'>Nucleotide</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/protein?term=txid"+obj.taxid+"[Organism]'> Protein</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "toolkit"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/toolkit/"+obj.uid+"'>"+obj.name+"</a><br>";
							rs += obj.def+"["+obj.modifiers+"&nbsp;&nbsp;"+obj.kind+"]<br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/IEB/ToolBox/CPP_DOC/doxyhtml/"+obj.link+"'>Doc</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/IEB/ToolBox/CPP_DOC/lxr/source/"+obj.file+"'>Definition</a>&nbsp;&nbsp;";
							rs += "<a href='hhttp://www.ncbi.nlm.nih.gov/IEB/ToolBox/CPP_DOC/lxr/ident?i="+obj.name+"&d=f'>X-refs</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/IEB/ToolBox/CPP_DOC/viewvc.cgi?p="+obj.file+"'>SVN Log</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/IEB/ToolBox/CPP_DOC/lib_search/libsearch.cgi?symbol="+obj.name+"'>Libs</a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/toolkitbook?term="+obj.name+"'>Book</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "unigene"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/UniGene/clust.cgi?UGID="+obj.uid+"&TAXID="+obj.taxid+"&SEARCH=apis%20mellifera'>"+obj.title+"</a><br>";
							rs += obj.gene+",&nbsp;&nbsp;<b>"+obj.organism+"</b><br>";
							rs += obj.clusterid+":&nbsp;"+obj.seq_count+"&nbsp;sequences.<br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "epigenomics"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/epigenomics/"+obj.uid+"'>"+obj.title+"</a><br>";
							rs += obj.summary+"<br>";
							rs += "<font color='silver'>ExperimentEpigenomics ID: "+obj.uid+" Accession number: "+obj.accession+"</font><br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/epigenomics/?db=epigenomics&cmd=link&linkname=epigenomics_epigenomics&uid="+obj.uid+"'>Similar</a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "homologene"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/homologene/"+obj.uid+"'>"+obj.title+"</a><br>";
							rs += obj.description+"<br>";
							rs += "<font color='silver'>hgid: "+obj.uid+"</font><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "toolkitbook"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/toolkit/doc/book/"+obj.rid+"'>"+obj.oid+" - "+obj.title+"</a><br>";
							rs += obj.bookinfo+"<br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "omim"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://omim.org/entry/"+obj.uid+"'>"+obj.title+"</a><br>";
							if(obj.locus != "")
								rs += "Cytogenetic locations: "+obj.locus+"<br>";
							rs += "<font color='silver'>OMIM: "+obj.uid+"</font><br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/gene?linkname=omim_gene&from_uid="+obj.uid+"'>Gene summaries </a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/gtr/tests/?term="+obj.uid+"[mim]'>Genetic tests  </a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/pubmed?linkname=omim_pubmed_cited&from_uid="+obj.uid+"'>Medical literature  </a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				if(db == "geoprofiles"){
					rs += "<table align='center' >";
					var num = 1;
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' width='10px;'>"+(data.start+num)+"、</td>";
							rs += "<td><a href='http://www.ncbi.nlm.nih.gov/geoprofiles/"+obj.uid+"'>"+(obj.orf==""?'':obj.orf+" - ")+obj.title+"</a><br>";
							if(obj.orf != "" && obj.genedesc != "")
								rs += "Annotation: <a href='http://www.ncbi.nlm.nih.gov/gene?Db=gene&DbFrom=geoprofiles&Cmd=Link&LinkName=geoprofiles_gene&IdsFromResult="+obj.uid+"'>"+obj.orf+"</a> , "+(obj.genedesc.indexOf('&lt;:&gt;')!=-1?obj.genedesc.substring(0,obj.genedesc.indexOf('&lt;:&gt;'))+"(multiple annotations exist)":obj.genedesc)+"<br>";
							else
								rs += "Annotation: No annotation available <br>";	
							rs += "Organism: <b>"+obj.taxon.substring(0,obj.taxon.indexOf(' '))+"</b>"+obj.taxon.substring(obj.taxon.indexOf(' '))+"<br>";
							rs += "Reporter: GPL "+obj.gpl+" , <b>"+obj.idref+"</b>(ID_REF), "+obj.orf+"(ORF)<br>";
							rs += "DataSet type: "+obj.gdstype+" , "+obj.valtype+"<br>";
							rs += "<font color='silver'>ID: "+obj.uid+"</font><br>";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/gds?LinkName=geoprofiles_gds&from_uid="+obj.uid+"'>GEO DataSets </a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/gene?LinkName=geoprofiles_gene&from_uid="+obj.uid+"'>Gene </a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/geoprofiles?LinkName=geoprofiles_geoprofiles_prof&from_uid="+obj.uid+"'>Profile neighbors  </a>&nbsp;&nbsp;";
							rs += "<a href='http://www.ncbi.nlm.nih.gov/geoprofiles?LinkName=geoprofiles_geoprofiles_chr&from_uid="+obj.uid+"'>Chromosome neighbors  </a><br><br>";
							num++;
						}
						rs += "</td></tr>";
					});
					rs += "</table>";
				}
				
				if(db == "clinvar"){
					rs += "<table align='center' >";
					$.each(data.result,function(i,obj){
						if(i != "uids"){
							rs += "<tr><td valign='top' colspan='2'><h2>"+obj.title+"</h2>";
							rs += "<h3><font color='red'>"+obj.title+"</font></h3></td></tr>";
							rs += "<tr><td>Variant type: </td><td>"+obj.variation_set[0].variant_type+"</td></tr>";
							rs += "<tr><td>Cytogenetic location: </td><td>---</td></tr>";
							if(obj.variation_set[0].variation_loc[0] != null){
								
								rs += "<tr><td>Genomic location: </td><td><font color='silver'>|</font>Chr10: "+obj.variation_set[0].variation_loc[0].stop+"(on Assembly "+obj.variation_set[0].variation_loc[0].assembly_name+")</td></tr>";
								rs += "<tr><td></td><td><font color='silver'>|</font>Chr10: "+obj.variation_set[0].variation_loc[1].stop+"(on Assembly "+obj.variation_set[0].variation_loc[1].assembly_name+")</td></tr>";
							}
							rs += "<tr><td>Protein change: </td><td>---</td></tr>";
							rs += "<tr><td>HGVS: </td><td>--</td></tr>";
							$.each(obj.variation_set[0].aliases,function(n,oname){
								
								rs += "<tr><td>Other names: </td><td><font color='silver'>|</font>"+oname+" , </td></tr>";
							});
							rs += "<tr><td>Links: </td><td>"+obj.variation_set[0].variation_xrefs[0].db_source+": <a href='http://www.omim.org/entry/"+obj.variation_set[0].variation_xrefs[0].db_id.replace('.','#')+"'>"+obj.variation_set[0].variation_xrefs[0].db_id+"</a></td></tr>";
							if(obj.variation_set[0].variation_xrefs[1] != null){
								
								rs += "<tr><td></td><td>"+obj.variation_set[0].variation_xrefs[1].db_source+": <a href='http://www.omim.org/entry/"+obj.variation_set[0].variation_xrefs[1].db_id.replace('.','#')+"'>"+obj.variation_set[0].variation_xrefs[1].db_id+"</a></td></tr>";
							}
							if(obj.variation_set[0].variation_loc[0] != null){
								rs += "<tr><td>NCBI 1000 Genomes Browser:</td><td><a href='http://www.ncbi.nlm.nih.gov/variation/tools/1000genomes/?chr=10&from="+obj.variation_set[0].variation_loc[0].start+"&to="+obj.variation_set[0].variation_loc[0].stop+"&gts=rs"+obj.variation_set[0].variation_xrefs[1].db_id+"&mk="+obj.variation_set[0].variation_loc[0].start+":"+obj.variation_set[0].variation_loc[0].stop+"|rs"+obj.variation_set[0].variation_xrefs[1].db_id+"'>rs"+obj.variation_set[0].variation_xrefs[1].db_id+"</a></td></tr>";
							}
							rs += "<tr><td>Molecular consequence:</td><td>--</td></tr>";
							
						}
					});
					rs += "</table>";
				}
				if(db == "dbvar"){
					var temptype = "";
					$.each(data.result,function(i,obj){
						if(obj.obj_type == "VARIANT")
							temptype = "VARIANT";
						if(obj.obj_type == "STUDY")
							temptype = "STUDY";
					});
					
					if(temptype == "VARIANT"){
							
						rs += "<table align='center' width='1000px;' style='border-collapse:collapse;'>";
						rs += "<tr><td valign='top' colspan='8'>";
						rs += "<h3><font color='red'>Number of Variants: "+data.count+"</font></h3></td></tr>";
						rs += "<tr  style='border:1px solid #eee;' bgcolor='#98D470'><td>Variant Region ID</td><td>Type</td><td>Number of Variant Calls</td><td>Study ID</td><td>Organism</td><td>Clinical Assertion</td><td>Location</td><td>Genes in region</td></tr>";
						$.each(data.result,function(i,obj){
							
							if(i != "uids"){
								
								rs += "<tr><td width='100px;'>"+obj.sv+"</td>";
								rs += "<td width='100px;'>"+obj.dbvarvarianttypelist[0]+"</td>";
								rs += "<td width='10px;'>"+obj.variant_call_count+"</td>";
								rs += "<td width='100px;'><a href='http://www.ncbi.nlm.nih.gov/dbvar/studies/"+obj.st+"'>"+obj.st+"</a></td>";
								rs += "<td width='100px;'>"+obj.organism+"</td>";
								rs += "<td width='90px;'></td>";
								rs += "<td width='400px;'>";
								$.each(obj.dbvarplacementlist,function(n,da){
									rs += "<a href='http://www.ncbi.nlm.nih.gov/dbvar/browse/org/?taxid="+da.assembly_tax_id+"&assm="+da.assembly_accession+"&chr="+da.chr_accession_version+"&studies="+obj.st+"&variant="+obj.sv+"'>"+da.assembly+"chr"+da.chr+":"+da.chr_outer_start+"-"+da.chr_outer_end+"</a> , ";
	
								});
								rs += "</td>";
								rs += "<td width='100px;'>";
								$.each(obj.dbvargenelist,function(m,dd){
									rs += dd.name+"<br>";
								});
								rs += "</td>";
								rs += "</tr>";
								
								
							}
						});
						rs += "</table>";
					}
					if(temptype == "STUDY"){
							
						rs += "<table align='center' width='1000px;' style='border-collapse:collapse;'>";
						rs += "<tr><td valign='top' colspan='8'>";
						rs += "<h3><font color='red'>Number of Studies: "+data.count+"</font></h3></td></tr>";
						rs += "<tr  style='border:1px solid #eee;' bgcolor='#98D470'><td>Study ID</td><td>Organism</td><td>Study type</td><td>Number of variant regions</td><td>Publication</td></tr>";
						$.each(data.result,function(i,obj){
							
							if(i != "uids"){
								
								rs += "<tr><td width='125px;'>"+obj.st+"</td>";
								rs += "<td width='125px;'>"+obj.dbvarstudyorglist[0].species+"</td>";
								rs += "<td width='150px;'>"+obj.study_type+"</td>";
								rs += "<td width='200px;'>"+obj.variant_count+"</td>";
								rs += "<td width='200px;'><a href='http://www.ncbi.nlm.nih.gov/pubmed/"+obj.dbvarpublicationlist[0].pmid+"'>"+obj.dbvarpublicationlist[0].publication_name+"</a> </td> ";
								
								rs += "</tr>";
								
								
							}
						});
						rs += "</table>";
					}
				
				}
				
				rs += "<table align='center' width='1000px;'><tr><td colspan='4' align='center'>";
				if(Math.ceil(data.count/20) != 0){
					
					if(retstart == 0){
						rs += "<font color='red'>第"+(data.start/20+1)+"页</font>&nbsp;";
						if(Math.ceil(data.count/20) != 1){
							
							rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&db="+db+"&retstart="+(data.start+20)+"'>下一页</a>&nbsp;";
							rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&db="+db+"&retstart="+((Math.ceil(data.count/20)-1)*20)+"'>末页</a>&nbsp;";
						}
	
					}else if(retstart == ((Math.ceil(data.count/20)-1)*20)){
						rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&db="+db+"&retstart=0'>首页</a>&nbsp;";
						rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&db="+db+"&retstart="+(data.start-20)+"'>上一页</a>&nbsp;";
						rs += "<font color='red'>第"+(data.start/20+1)+"页</font>&nbsp;";
					}else{
						rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&db="+db+"&retstart=0'>首页</a>&nbsp;";
						rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&db="+db+"&retstart="+(data.start-20)+"'>上一页</a>&nbsp;";
						rs += "<font color='red'>第"+(data.start/20+1)+"页</font>&nbsp;";
						rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&db="+db+"&retstart="+(data.start+20)+"'>下一页</a>&nbsp;";
						rs += "<a href='namesearchncbi.jsp?scientificName="+scientificName+"&db="+db+"&retstart="+((Math.ceil(data.count/20)-1)*20)+"'>末页</a>&nbsp;";
	
					}
					rs += "共<font color='red'>"+Math.ceil(data.count/20)+"</font>页";
				}else{
					rs += "共<font color='red'>0</font>页";
				}
				rs += "</td><tr></table>";
				$("#rs_data").append(rs);
			});
});



</script>
</head>
<body>
<div id="rs_data"></div>
<br>
<table><tr ><td  style="text-align: " colspan="1"></td></tr></table>
</body>
</html>