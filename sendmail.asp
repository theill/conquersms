<%	Option Explicit
	
	'
	' ConquerSMS:sendmail.asp
	' 
	' @author	Peter Theill, theill.com	pt@theill.com
	' @date	October 22, 2000	-- initial release
	' @date	October 29, 2000	-- added multiple receivers
	' @date	4/28/2001 11:06AM	-- added JMail support 
	'
	
	' *** USER SETTINGS START ***
	
	' type of mail component ("ASPMail" or "JMail") -- check with your
	' service provider to find out which one you have installed on the
	' server
	Const MAIL_COMPONENT = "ASPMail"
	
	' make sure this is a valid email address -- some SMTP servers does
	' not allow sending emails if FROM: email is a non existing address
	Const SERVER_EMAIL = "conquersms@theill.com"
	
	' type your SMTP Server in this field -- if you are hosted at e.g.
	' "www.fuzzy.lgk" you probably type in "mail.fuzzy.lgk"
	Const SMTP_SERVER = "mail.theill.com"
	
	' *** USER SETTINGS END ***
	
	Response.Buffer = True
	
	' list of recognized telcos for sending out SMS
	Const teledk		= "sms.tdm.dk"
	Const sonofon		= "note.sonofon.dk"
	Const telia			= "gsm1800.telia.dk"
	Const mobilix		= "sms.mobilix.dk"
	Const tele1			= "sms.mobilix.dk"
	Const telepartner	= "sms.mobilix.dk"
	Const mfs			= "sms.mobilix.dk"
	Const tele1020		= "sms.mobilix.dk"
	Const rslcom		= "sms.mobilix.dk"
	Const netsource		= "sms.mobilix.dk"
	Const facilicom		= "sms.mobilix.dk"
	Const telepassport	= "sms.mobilix.dk"
	Const telefona		= "sms.tdm.dk"
	Const worldOnline	= "sms.tdm.dk"
	
	Function getTelcoEmail(identifier)
		
		If ( (identifier >= 2010) AND (identifier <= 2059) ) Then
		  getTelcoEmail = teledk
		ElseIf ( (identifier >= 2060) AND (identifier <= 2099) ) Then
		  getTelcoEmail = sonofon
		ElseIf ( (identifier >= 2110) AND (identifier <= 2199) ) Then
		  getTelcoEmail = teledk
		ElseIf ( (identifier >= 2210) AND (identifier <= 2299) ) Then
		  getTelcoEmail = sonofon
		ElseIf ( (identifier >= 2310) AND (identifier <= 2399) ) Then
		  getTelcoEmail = teledk
		ElseIf ( (identifier >= 2610) AND (identifier <= 2699) ) Then
		  getTelcoEmail = mobilix
		ElseIf ( (identifier >= 2810) AND (identifier <= 2899) ) Then
		  getTelcoEmail = telia
		ElseIf ( (identifier >= 2900) AND (identifier <= 2999) ) Then
		  getTelcoEmail = telefona
		ElseIf ( (identifier >= 3010) AND (identifier <= 3689) ) Then
		  getTelcoEmail = teledk
		ElseIf ( (identifier >= 3690) AND (identifier <= 3309) ) Then
		  getTelcoEmail = tele1
		ElseIf ( (identifier >= 3810) AND (identifier <= 4049) ) Then
		  getTelcoEmail = teledk
		ElseIf ( (identifier >= 4050) AND (identifier <= 4099) ) Then
		  getTelcoEmail = sonofon
		ElseIf ( (identifier >= 4320) AND (identifier <= 4679) ) Then
		  getTelcoEmail = teledk
		ElseIf ( (identifier >= 4690) AND (identifier <= 4709) ) Then
		  getTelcoEmail = tele1
		ElseIf ( (identifier >= 4710) AND (identifier <= 4979) ) Then
		  getTelcoEmail = teledk
		ElseIf ( (identifier >= 5180) AND (identifier <= 5180) ) Then
		  getTelcoEmail = worldOnline
		ElseIf ( (identifier >= 5184) AND (identifier <= 5184) ) Then
		  getTelcoEmail = worldOnline
		ElseIf (identifier = 6910) Then
		  getTelcoEmail = telepartner
		ElseIf (identifier = 6911) Then
		  getTelcoEmail = mfs
		ElseIf (identifier = 6912) Then
		  getTelcoEmail = tele1020
		ElseIf ( (identifier >= 6960) AND (identifier <= 6964) ) Then
		  getTelcoEmail = rslcom
		ElseIf (identifier = 6966) Then
		  getTelcoEmail = netsource
		ElseIf (identifier = 6969) Then
		  getTelcoEmail = netsource
		ElseIf ( (identifier >= 6980) AND (identifier <= 6989) ) Then
		  getTelcoEmail = facilicom
		ElseIf (identifier = 6996) Then
		  getTelcoEmail = telepassport
		Else
			getTelcoEmail = ""
		End If
		
	End Function
	
	Dim messageSend, returnMessage
	messageSend = False
	returnMessage = ""

	If (Request("action") = "send") Then
		
		Dim sender, arReceivers, receiver, message
		
		sender = Trim(CStr(Request.Form("ediSender")))
		receiver = Replace(Trim(CStr(Request.Form("ediReceiver"))), " ", "")
		message = Trim(CStr(Request.Form("ediMessage")))
		
		' get array of all receivers
		arReceivers = Split(receiver, ",")
		receiver = arReceivers(0)
		
		' we store a cookie in order to remember who send
		' this message
		Response.Cookies("ConquerSMSAddress")("Sender") = sender
		Response.Cookies("ConquerSMSAddress").Expires = Date + 365
		Response.Cookies("ConquerSMSAddress").Domain = "/"
		
'		message = Replace(message, "Æ", Chr(28))
'		message = Replace(message, "æ", Chr(29))
		
'		message = Replace(message, "Ø", Chr(11))
'		message = Replace(message, "ø", Chr(12))
		
'		message = Replace(message, "Å", Chr(14))
'		message = Replace(message, "å", Chr(15))
		
		Dim i		
		For i = 0 To UBound(arReceivers)
			receiver = arReceivers(i)
			
			If (NOT IsNumeric(receiver)) Then
				receiver = 0
			End If
			
			receiver = Int(receiver)
			
			Dim identifier
			identifier = Int(Left(receiver, 4))
			
			If ((identifier >= 2010) AND (Len(receiver) >= 8)) Then
			
				' try to send message if a valid number were entered
				Dim userAddress
				userAddress = receiver & "@" & getTelcoEmail(identifier)
				
				Dim Mailer
				
				' patch sender to include some pre/post characters for nicer
				' formatting when printing in message
				If (Len(sender) > 0) Then
					sender = "Fra " & sender & ":"
				Else
					sender = ""
				End If
				
				Dim mailResponse, formattedMessage, partMessage, sIdx
				sIdx = 1
				formattedMessage = ""
				
				Dim cnt, wordCutPos
				cnt = 0
				
				Do
				
					partMessage = Mid(message, sIdx, 140-Len(sender)-1)
					
					' do some word cutting, finding a word to split up
					' message nicely. We need to check for the end of
					' this partial message thus we use InStrRev()
					wordCutPos = InStrRev(partMessage, " ")
					If ((wordCutPos > 0) AND (Len(message) > (sIdx+Len(partMessage)))) Then
'						formattedMessage = formattedMessage & "<b>WORDBRE <font color=yellow>"&partMessage &"</font> AKFOUND</b>"
						partMessage = Left(partMessage, wordCutPos)
'						sIdx = sIdx + 1
					End If
					
					formattedMessage = formattedMessage & partMessage & "<p>"
					
					If (LCase(MAIL_COMPONENT) = "aspmail") Then
						' I need to create a new one every time in order to send
						' multiple emails -- it's a bug in this object.
						Set Mailer = Server.CreateObject("SMTPsvg.Mailer")
						Mailer.CharSet = 2
						Mailer.RemoteHost = SMTP_SERVER
'							Mailer.FromName = sender
						Mailer.FromAddress = SERVER_EMAIL
						Mailer.AddRecipient userAddress, userAddress
						Mailer.Subject = ""
						Mailer.BodyText = sender & partMessage
						
						messageSend = Mailer.SendMail
						If (NOT messageSend) Then
							mailResponse = mailResponse & Mailer.Response & "<br />"
						End If
						
						Mailer.ClearRecipients()
					Else
						' JMail
						Set Mailer = Server.CreateObject("JMail.Message")
						Mailer.Logging = True
						Mailer.Silent = True
						Mailer.From = SERVER_EMAIL
						Mailer.FromName = sender
						Mailer.CharSet = "iso-8859-1"
						Mailer.AddRecipient userAddress, userAddress
						Mailer.Subject = ""
						Mailer.Body = sender & partMessage
						
						messageSend = Mailer.Send(SMTP_SERVER)
						If (NOT messageSend) Then
							mailResponse = mailResponse & Mailer.Log & "<br />"
						End If
						
						Mailer.ClearRecipients()
						
					End If
					
					' next message
					sIdx = sIdx + Len(partMessage)
					
					cnt = cnt + 1
					
					If (cnt > 10) Then
						' do NOT send more than ten messages total
						messageSend = False
					End If
					
					Set Mailer = Nothing
					
				Loop While ( messageSend AND (Len(message) > sIdx) )
				
				If (NOT messageSend) Then
					returnMessage = mailResponse
				End If
				
				Set Mailer = Nothing
			Else
				messageSend = False
			End If
			
		Next
		
	Else
		Response.Redirect "default.asp"
	End If ' // > If (Request("action") = "send") Then
	
%>
<html>

<head>
 <title>ConquerSMS @ theill.com</title>
 <link rel="stylesheet" type="text/css" href="default.css">
</head>

<body bgcolor="#01356C" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0 background="images/bluestripe.gif">

<div align="center">
  <center>

<table width="590" border="0" cellspacing="8" cellpadding="0" bgcolor="#336699" height="100%">
<tr>
 <td valign="top" bgcolor="#FFFFFF"><img border="0" src="images/dot.gif" width="2" height="2"></td>
 <td valign="top">

          <p align="justify">
          &nbsp;
          </p>

          <p align="center">
          <img border="0" src="images/ConquerSMS.gif" width="273" height="74" alt="ConquerSMS">
          </p>

			<% If (returnMessage = "") Then %>
          <p align="justify">Nedenstående <% If (cnt > 1) Then Response.Write cnt & " beskeder" Else Response.Write "besked" End If %> til <b><%= Request.Form("ediReceiver") %></b> er nu
          blevet afsendt.<br>
          <ul>
	          <%= formattedMessage %>
<!--	          <%= Request.Form("ediMessage") %> -->
          </ul>
          </p>
          <% Else %>
          <p align="justify">Der opstod et problem ved afsendelsen af din besked:<br>
          <ul>
	          <%= returnMessage %>
          </ul>
          </p>
          <% End If %>

          <p align="justify">
          &nbsp;
          </p>

          <p align="justify"><b><a href="default.asp">« Tilbage</a></b></p>

          <p align="justify" class="BottomNote"><img border="0" src="images/whiteline.gif" width="25%" height="1"><br><br>
          <b>Bemærk:</b><BR>ConquerSMS og dets ejere kan under ingen omstændigheder drages til ansvar for indholdet eller følgerne af afsendte beskeder via denne service. Har De spørgsmål vedr. ConquerSMS, bedes De sender en email til: <a href="mailto:conquersms@theill.com">conquersms@theill.com</a>.</p>
 </td>
 <td valign="top" bgcolor="#FFFFFF"><img border="0" src="images/dot.gif" width="2" height="2"></td>
</tr>
</table>

  </center>
</div>

</body>
</html>



