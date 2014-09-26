<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
response.setDateHeader("Expires", 0);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GRIB Request</title>
<STYLE TYPE="text/css">
h1    {text-align:center}
table {background-color:silver;border-style:solid;border-color:black;border-width:1}
td    {background-color:white;border-style:solid;border-color:black;border-width:1}
th    {background-color:white;border-style:solid;border-color:black;border-width:1}
</STYLE>
</head>
<body>

<table align=center>
<TR><TD><img src="rayAWIPS.jpg" align=middle></TD>
<TD><H1>&mu;Engine Demonstration<BR>Simple GRIB Retrieval</H1>
<CENTER>Form Driven Test Page</CENTER></TD>
<TD><img src="rayAWIPS.jpg" align=middle></TD></TR>
</table>

<form method=post action="runAction.jas">
<input type=hidden name=requesttype value=grib>
<input type=hidden name=datatype value=grib>
<input type=hidden name=plugin value=grib>
<input type=hidden name=sortby value="basetime">

<table width="50%" align=center>
<TR>
<TH colspan=3>Enter Action Script Parameters and press Submit.</TH>
</TR>

<TR>
<TD><B>Name:</B></TD>
<TD colspan=2><input type=text name=scriptname value="Grib Image Demo"></TD>
</TR>

<TR>
<TD><B>DataType:</B></TD>
<TD colspan=2><em>Grib</em></TD>
</TR>

<TR>
<TD ROWSPAN=4><B>Query Parameters:</B></TD>
<TD>Parameter Name:</TD>
<TD><input type=text name=parameter value=Temperature></TD>
</TR>

<TR>
<TD>Parameter Level:</TD>
<TD>
   <input type=text name=level1 value="2.0" size=3>&ndash;<input type=text name=level2 size=3>
   <input type=text name=unit value=m size=2>
</TD>
</TR>

<TR>
<TD>Forecast Time:</TD>
<TD><input type=text name=forecast value=0></TD>
</TR>

<TR>
<TD>Count:</TD>
<TD>
<select name=count>
   <option value=1 selected>1 image
   <option value=2>2 images
   <option value=3>3 images
   <option value=4>4 images
   <option value=5>5 images
   <option value=6>6 images
   <option value=7>7 images
   <option value=8>8 images
   <option value=9>9 images
   <option value=10>10 images
</select>
</TD>
</TR>

<TR>
<TD ROWSPAN=3><B>Grib Mapping:</B></TD>
<TD>Factor:</TD>
<TD><input type=text name=scalefactor value=3></TD>
</TR>

<TR>
<TD>Minimum:</TD>
<TD><input type=text name=minimum value=220></TD>
</TR>

<TR>
<TD>Maximum:</TD>
<TD><input type=text name=maximum value=335></TD>
</TR>

<TR>
<TD ROWSPAN=3><B>Image Options:</B></TD>
<TD>Color Map:</TD>
<TD>
   <select name=colormap>
      <option value="BW">Grey Scale
      <option value="GribTempRGB" SELECTED>Grib Temp RGB
      <option value="GribRGB">Grib RGB
      <option value="64RGB">64 Color RGB
      <option value="IREnhanced">IR Enhanced
      <option value="64BW">Grey Scale (64 color)
   </select>
</TD>
</TR>

<TR>
<TD>Format:</TD>
<TD>
   <select name=imageformat>
      <option value="png">PNG Format
      <option value="tiff">Tagged Image Format
      <option value="jpg">JPEG Format
      <option value="gif">GIF Format
      <option value="bmp">BMP Format
   </select>
</TD>
</TR>

<TR>
<TD><input type=checkbox name=reproject>Reproject</TD>
<TD><input type=checkbox name=tile disabled>Tile Image</TD>
</TR>

<TR>
<td rowspan=2><B>Actions:</B></TD>
<TD>Disseminate:</TD>
<TD>
   <input type=checkbox name=disseminate disabled> 
   <input type="text" name="client" disabled>
</TD>
</TR>

<tr>
<td colspan=2>
<input type=radio name=function value=subscribe>Subscribe
<input type=radio name=function value=execute checked>Execute</TD>
</TR>

</table>
<br>
<div align=center>
<input type="submit" value="Get Image">
<input type=reset> 
Timeout:
<select name=receiveTime>
   <option value=60000>1 minute
   <option value=120000 selected>2 minutes
   <option value=180000>3 minutes
   <option value=240000>4 minutes
   <option value=300000>5 minutes
   <option value=360000>6 minutes
   <option value=420000>7 minutes
   <option value=480000>8 minutes
   <option value=540000>9 minutes
   <option value=600000>10 minutes
</select>
</div>
<br>
</form>

</body>
</html>