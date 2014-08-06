<%	Option Explicit
	
	'
	' ConquerSMS:default.asp
	' 
	' author: Peter Theill, theill.com
	' email: pt@theill.com
	' date: October 22, 2000
	'
	
	Response.Buffer = True
	
	If (Request("action") = "save") Then
		
		Response.Cookies("ConquerSMSAddress")("Name1") = Request.Form("ediName1")
		Response.Cookies("ConquerSMSAddress")("Name2") = Request.Form("ediName2")
		Response.Cookies("ConquerSMSAddress")("Name3") = Request.Form("ediName3")
		Response.Cookies("ConquerSMSAddress")("Name4") = Request.Form("ediName4")
		Response.Cookies("ConquerSMSAddress")("Name5") = Request.Form("ediName5")
		Response.Cookies("ConquerSMSAddress")("Name6") = Request.Form("ediName6")
		Response.Cookies("ConquerSMSAddress")("Name7") = Request.Form("ediName7")
		Response.Cookies("ConquerSMSAddress")("Name8") = Request.Form("ediName8")
		Response.Cookies("ConquerSMSAddress")("Name9") = Request.Form("ediName9")
		Response.Cookies("ConquerSMSAddress")("Name10") = Request.Form("ediName10")

		Response.Cookies("ConquerSMSAddress")("Phone1") = Request.Form("ediPhone1")
		Response.Cookies("ConquerSMSAddress")("Phone2") = Request.Form("ediPhone2")
		Response.Cookies("ConquerSMSAddress")("Phone3") = Request.Form("ediPhone3")
		Response.Cookies("ConquerSMSAddress")("Phone4") = Request.Form("ediPhone4")
		Response.Cookies("ConquerSMSAddress")("Phone5") = Request.Form("ediPhone5")
		Response.Cookies("ConquerSMSAddress")("Phone6") = Request.Form("ediPhone6")
		Response.Cookies("ConquerSMSAddress")("Phone7") = Request.Form("ediPhone7")
		Response.Cookies("ConquerSMSAddress")("Phone8") = Request.Form("ediPhone8")
		Response.Cookies("ConquerSMSAddress")("Phone9") = Request.Form("ediPhone9")
		Response.Cookies("ConquerSMSAddress")("Phone10") = Request.Form("ediPhone10")

		Response.Cookies("ConquerSMSAddress").Expires = Date + 365
		Response.Cookies("ConquerSMSAddress").Domain = "/"
		
	End If ' // > If (Request("action") = "save") Then
	
%>
<html>

<head>
 <title>ConquerSMS @ theill.com</title>
 <link rel="stylesheet" type="text/css" href="default.css">
 <script language="javascript">
 <!--
	var maxChars = 800;
	var ob = "nssucks"
	var receiverName = "modtager";
	
	function checkLength()
	{
		mesLength = document.frmMessage.ediMessage.value.length;
		senderLength = document.frmMessage.ediSender.value.length;
		
		var msgCnt = Math.round(Math.abs(mesLength - senderLength) / 140 + 0.5);
//		var mesStat = "besked til " + receiverName + ",  " + mesLength + " tegn i " + msgCnt + " besked";
		var mesStat = "besked, " + mesLength + " tegn i " + msgCnt + " besked";
		
		// let's do a bit of grammar
		if (msgCnt != 1)
			mesStat += "er";
		
		mesStatus.innerHTML = mesStat;
		
		if (mesLength > maxChars)
		{
			self.window.alert( "Din besked må ikke ikke indeholde mere end " + maxChars + " tegn." );
			document.frmMessage.ediMessage.value = document.frmMessage.ediMessage.value.substr(0, maxChars);
		}
		
	}
	
	function sendSMS()
	{
		if (document.frmMessage.ediReceiver.value.length < 5)
			self.window.alert("De mangler at indtaste et mobil nummer");
		else if (document.frmMessage.ediMessage.value.length < 2)
			self.window.alert("De mangler at indtaste en besked");
		else
			return true;
			
		return false;
	}
	
	function addToMessageArea()
	{
		document.frmMessage.ediMessage.value = document.frmMessage.ediMessage.value + document.frmMessage.cmbStandardMessages.options[document.frmMessage.cmbStandardMessages.selectedIndex].value;
		checkLength();
		
		document.frmMessage.ediMessage.focus();
	}
	
	function clearMessageArea()
	{
	
		if ((document.frmMessage.ediMessage.value.length < 50) || confirm("Er du sikker på, du ønsker at slette hele din besked?"))
		{
			document.frmMessage.ediMessage.value = "";
			checkLength();
			document.frmMessage.ediMessage.focus();
		}
	}
	
	function selectAddress()
	{
		receiverName = "";
		var phones = "";
		
		var tmp;
		
		var i = 0;
//		for (; i < document.frmAddress.rbAddress.length; i++)
		for (; i < 10; i++)
		{
			if (eval("document.frmAddress.ckbAddress"+(i+1)).checked)
			{
				tmp = eval("document.frmAddress.ediName"+(i+1)).value;
				if (tmp != "")
				{
					receiverName = receiverName + tmp + ", ";
				}
				
				tmp = eval("document.frmAddress.ediPhone"+(i+1)).value;
				if (tmp != "")
				{
					phones = phones + tmp + ", ";
				}
			}
		}
		
		// remove last pair of ', ' for both name and phone string
		receiverName = receiverName.substr(0, receiverName.length-2);
		phones = phones.substr(0, phones.length-2);
		
//		receiverName = eval("document.frmAddress.ediName"+(i+1)).value;
//		document.frmMessage.ediReceiver.value = eval("document.frmAddress.ediPhone"+(i+1)).value;
		document.frmMessage.ediReceiver.value = phones;
		document.frmMessage.ediMessage.focus();
		
// enable for some nice focus effects
//		tblMessage.bgColor = "#225588";
//		tblAddress.bgColor = "#336699";
		
		if (receiverName == "")
			receiverName = "modtager";
		
		msgReceiveMobile.innerHTML = "mobil nummer til " + receiverName;
//		checkLength();
	}
	
 //-->
 </script>
</head>

<body bgcolor="#01356C" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
<% Response.Flush %>

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
          <img src="images/ConquerSMS.gif" border="0" alt="ConquerSMS" width="273" height="74">
          </p>

          <p align="justify"><font size=2 face="verdana, sans-serif" color=white>
          Du har via <b> ConquerSMS</b> muligheden for at sende SMS-beskeder til alle danske
          GSM mobiltelefoner. En SMS besked består af max. 160 karakterer. Hvis
          du skriver en besked der er længere, vil ConquerSMS automatisk opdele
          den i flere beskeder og sende disse samtidigt. Det kan dog forekomme, at
          beskederne modtages i en forkert rækkefølge; dette skyldes den protokol
          der anvendes af telefonselskaberne.
          </font>
          </p>

          <p align="justify">ConquerSMS stilles gratis til rådighed af <a href="http://www.conquerware.dk/" target="_blank">ConquerWare</a>.
          </p>

          <table border="0" cellpadding="4" cellspacing="0" width="100%">
            <tr>
              <td valign="top" bgcolor="#01356C" colspan="2" background="images/bluestripe.gif"><b>Besked</b></td>
              <td bgcolor="#01356C" colspan="2" background="images/bluestripe.gif"><b>Adressebog</b></td>
            </tr>
            <tr id="tblMessage" bgcolor="#225588">
              <td valign="top"></td>
              <td width="50%" valign="top"><table border="0" cellpadding="2" cellspacing="0" width="100%">
			<form action="sendmail.asp" method="POST" name="frmMessage">
			<input type="hidden" name="action" value="send">
            <tr>
              <td width="100%" class="SmallCaption"><div id="msgReceiveMobile">mobil nummer til modtager</div></td>
            </tr>
            <tr>
              <td width="100%"><input type="text" name="ediReceiver" size="20" style="width: 100%;"></td>
            </tr>
            <tr>
              <td width="100%" class="SmallCaption"><img border="0" src="images/dot.gif" width="16" height="4"></td>
            </tr>
            <tr>
              <td width="100%" class="SmallCaption"><DIV id=mesStatus style="font-family: verdana, sans-serif; font-size: 7.5pt;">besked til modtager</DIV></td>
            </tr>
            <tr>
              <td width="100%"><textarea rows="6" name="ediMessage" wrap="VIRTUAL" cols="20" style="width: 100%;" onKeyUp="checkLength()" maxlength="160"></textarea></td>
            </tr>
            <tr>
              <td width="100%" class="SmallCaption"><img border="0" src="images/dot.gif" width="16" height="4"></td>
            </tr>
            <tr>
              <td width="100%" class="SmallCaption">tilføj standard beskeder</td>
            </tr>
            <tr>
              <td width="100%" class="SmallCaption"><select size="1" name="cmbStandardMessages" style="width: 100%" onChange="addToMessageArea()">
                  <option selected value="">-- ingen valgt --</option>
            <option value="Jeg elsker dig!">Jeg elsker dig!</option>
            <option value="Tillykke med fødselsdagen!">Tillykke med fødselsdagen!</option>
            <option value="Skal vi mødes senere??">Skal vi mødes senere ??</option>
            <option value="Hey Babe! :-)">Hey Babe! :-)</option>
            <option value="Vil du med mig i byen i weekenden? *ss*">Vil du med mig i byen i weekenden? *ss*</option>
            <option value="Tak for sidst!">Tak for sidst!</option>
            <option value="Jeg kan ikke komme alligevel :o(">Jeg kan ikke komme alligevel :o(</option>
            <option value="Jeg savner dig!!">Jeg savner dig!!</option>
            <option value="Vi ses senere!!">Vi ses senere!!</option>
            <option value="Jeg bliver lettere forsinket.. beklager :-/">Jeg bliver lettere forsinket.. beklager :-/</option>
            <option value="Jeg er lige på arbejde - ringer når jeg kommer hjem!">Jeg er lige på arbejde - ringer når jeg kommer hjem!</option>
            <option value="Du er så smuk, at det burde være forbudt ;-)">Du er så smuk, at det burde være forbudt ;-)</option>
            <option value="Hey smukke pige - kom ind i Mujaffas BMW! :-)">Hey smukke pige - kom ind i Mujaffas BMW! :-)</option>
            <option value="Godnat smukke - drøm sødt *ss*">Godnat smukke - drøm sødt *ss*</option>
            <option value="Send gratis SMS beskeder til mobil telefon fra www.theill.com/conquersms">Send gratis SMS beskeder fra www.theill.com/conquersms</option>
                </select></td>
            </tr>
            <tr>
              <td width="100%" class="SmallCaption"><img border="0" src="images/dot.gif" width="16" height="4"></td>
            </tr>
            <tr>
              <td width="100%" class="SmallCaption">navn på afsender</td>
            </tr>
            <tr>
              <td width="100%"><input type="text" name="ediSender" size="20" style="width: 100%;" value="<%= Request.Cookies("ConquerSMSAddress")("Sender") %>"></td>
            </tr>
            <tr>
              <td width="100%" align="right"><img border="0" src="images/dot.gif" width="16" height="4"></td>
            </tr>
            <tr>
              <td width="100%" align="right"><input type="button" value=" rens " name="btnReset" class="submitButton" onClick="clearMessageArea()">&nbsp;<input type="submit" value=" send " name="btnSend" class="submitButton" onClick="return sendSMS()"></td>
            </tr>
          </form>
          </table></td>
              <td valign="top"></td>
              <td width="50%" valign="top" bgcolor="#225588" id="tblAddress">
                <table border="0" cellpadding="2" cellspacing="0" width="100%">
              			<form action="default.asp" method="post" name="frmAddress">
              			<input type="hidden" name="action" value="save">
                  <tr>
                    <td align="center" class="SmallCaption"></td>
                    <td width="100%" class="SmallCaption">navn</td>
                    <td class="SmallCaption">nummer</td>
                    <td class="SmallCaption"></td>
                  </tr>
                  <tr>
                    <td align="center"><input type="checkbox" onClick="return selectAddress()" value="on1" name="ckbAddress1"></td>
                    <td width="100%"><input type="text" name="ediName1" value="<%= Request.Cookies("ConquerSMSAddress")("Name1") %>" size="10" style="width: 100%;"></td>
                    <td><input type="text" name="ediPhone1" value="<%= Request.Cookies("ConquerSMSAddress")("Phone1") %>" size="8"></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td align="center"><input type="checkbox" value="on2" name="ckbAddress2" onClick="return selectAddress()"></td>
                    <td width="100%"><input type="text" name="ediName2" value="<%= Request.Cookies("ConquerSMSAddress")("Name2") %>" size="10" style="width: 100%;"></td>
                    <td><input type="text" name="ediPhone2" value="<%= Request.Cookies("ConquerSMSAddress")("Phone2") %>" size="8"></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td align="center"><input type="checkbox" value="on3" name="ckbAddress3" onClick="return selectAddress()"></td>
                    <td width="100%"><input type="text" name="ediName3" value="<%= Request.Cookies("ConquerSMSAddress")("Name3") %>" size="10" style="width: 100%;"></td>
                    <td><input type="text" name="ediPhone3" value="<%= Request.Cookies("ConquerSMSAddress")("Phone3") %>" size="8"></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td align="center"><input type="checkbox" value="on4" name="ckbAddress4" onClick="return selectAddress()"></td>
                    <td width="100%"><input type="text" name="ediName4" value="<%= Request.Cookies("ConquerSMSAddress")("Name4") %>" size="10" style="width: 100%;"></td>
                    <td><input type="text" name="ediPhone4" value="<%= Request.Cookies("ConquerSMSAddress")("Phone4") %>" size="8"></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td align="center"><input type="checkbox" value="on5" name="ckbAddress5" onClick="return selectAddress()"></td>
                    <td width="100%"><input type="text" name="ediName5" value="<%= Request.Cookies("ConquerSMSAddress")("Name5") %>" size="10" style="width: 100%;"></td>
                    <td><input type="text" name="ediPhone5" value="<%= Request.Cookies("ConquerSMSAddress")("Phone5") %>" size="8"></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td align="center"><input type="checkbox" value="on6" name="ckbAddress6" onClick="return selectAddress()"></td>
                    <td width="100%"><input type="text" name="ediName6" value="<%= Request.Cookies("ConquerSMSAddress")("Name6") %>" size="10" style="width: 100%;"></td>
                    <td><input type="text" name="ediPhone6" value="<%= Request.Cookies("ConquerSMSAddress")("Phone6") %>" size="8"></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td align="center"><input type="checkbox" value="on7" name="ckbAddress7" onClick="return selectAddress()"></td>
                    <td width="100%"><input type="text" name="ediName7" value="<%= Request.Cookies("ConquerSMSAddress")("Name7") %>" size="10" style="width: 100%;"></td>
                    <td><input type="text" name="ediPhone7" value="<%= Request.Cookies("ConquerSMSAddress")("Phone7") %>" size="8"></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td align="center"><input type="checkbox" value="on8" name="ckbAddress8" onClick="return selectAddress()"></td>
                    <td width="100%"><input type="text" name="ediName8" value="<%= Request.Cookies("ConquerSMSAddress")("Name8") %>" size="10" style="width: 100%;"></td>
                    <td><input type="text" name="ediPhone8" value="<%= Request.Cookies("ConquerSMSAddress")("Phone8") %>" size="8"></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td align="center"><input type="checkbox" value="on9" name="ckbAddress9" onClick="return selectAddress()"></td>
                    <td width="100%"><input type="text" name="ediName9" value="<%= Request.Cookies("ConquerSMSAddress")("Name9") %>" size="10" style="width: 100%;"></td>
                    <td><input type="text" name="ediPhone9" value="<%= Request.Cookies("ConquerSMSAddress")("Phone9") %>" size="8"></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td align="center"><input type="checkbox" value="on10" name="ckbAddress10" onClick="return selectAddress()"></td>
                    <td width="100%"><input type="text" name="ediName10" value="<%= Request.Cookies("ConquerSMSAddress")("Name10") %>" size="10" style="width: 100%;"></td>
                    <td><input type="text" name="ediPhone10" value="<%= Request.Cookies("ConquerSMSAddress")("Phone10") %>" size="8"></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td align="center"></td>
                    <td width="100%"></td>
                    <td align="right"><img border="0" src="images/dot.gif" width="16" height="4"></td>
                    <td></td>
                  </tr>
                  <tr>
                    <td align="center"></td>
                    <td width="100%"></td>
                    <td align="right"><input type="submit" value=" gem " name="btnSave" class="submitButton"></td>
                    <td></td>
                  </tr>
                </form>
                </table>
              </td>
            </tr>
          </table>

          <p align="justify"><b>Vejledning:</b><br>
          For at sende en besked, skal indtastes et mobil nummer og en besked.
          Hvis De ønsker at sende en standard besked, vælges denne fra
          drop-down listen. Bemærk venligst, at beskeden <i>tilføjes</i>, og
          ikke sletter, Deres allerede indtastede tekst.</p>

          <p align="justify">Efterhånden som beskeden skrives, opdateres
          antallet af karakterer samt antallet af beskeder, der vil blive sendt
          til modtageren (dog kun hvis du bruger Internet Explorer browseren).
          Det kan ske, at der sendes en besked mere, da ConquerSMS automatisk
          kigger på den sendte besked og deler beskederne i hele ord, dvs
          modtageren vil ikke få to beskeder, hvor han/hun bliver nødt til at
          sammenholde de to for at finde eet ord.</p>

          <p align="justify"><b>Andre services fra <font color="#99CCFF">Conquer</font>
          serien:</b><br>
          En online bookmark manager <a href="http://www.theill.com/ConquerMarks/default.asp">ConquerMarks</a>
          og et simpelt chatforum <a href="http://www.theill.com/chat/default.asp">ConquerChat</a>.
          Sourcecoden til alle services kan hentes frit på <a href="http://www.theill.com/asp.asp">http://www.theill.com/asp.asp</a>.</p>
          <p align="justify" class="BottomNote"><img border="0" src="images/whiteline.gif" width="25%" height="1"><br><br>
          <b>Bemærk:</b><BR>ConquerSMS
          og dets ejere kan under ingen omstændigheder drages til 
ansvar for indholdet eller følgerne af afsendte beskeder via denne service. Har
          De spørgsmål vedr. ConquerSMS, bedes De sender en email til: <a href="mailto:conquersms@theill.com">conquersms@theill.com</a>.</p></td>
 <td valign="top" bgcolor="#FFFFFF"><img border="0" src="images/dot.gif" width="2" height="2"></td>
</tr>
</table>

  </center>
</div>

</body>
</html>