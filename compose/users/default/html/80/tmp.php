<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>YYY</title>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body>

<div id="wrapper">

  <div id="header">

    <div class="top_banner">
      <h1>Bienvenue sur votre site YYY,</h1>
      <p>vous pouvez d'ores-et-déjà l'éditez au sein de votre dossier html/80/ en vous connectant sur le serveur avec vos identifiants FTP. Ce même site est disponible sur la suite de port 11000 de part le service Varnish.</p>
    </div>
  </div>

    </br></br>

    <h2> Informations concernant votre site internet : </h2>

    </br>

<?php
$bdd = new PDO('mysql:host=172.17.0.1:PORT;dbname=docker','root','PASSWORD');
?>

<table class="contacts" cellspacing="0" summary="Contacts template">
<tr>
<td class="contactDept" colspan="3">Informations</td>
</tr>
<tr>
<td class="contact" width="25%">Base de données</td>
<td class="contact" width="60%"><?php echo "ip_port"?></td>
<td class="contact" width="15%"><p style="color:#228B22">Connexion Réussie</p></td>
</tr>
<tr>
<td class="contact">PHP-FPM</td>
<td class="contact"><?php echo "php_container"?></td>
<td class="contact"><p style="color:#228B22">Connexion Réussie</p></td>
</tr>
<tr>
<td class="contact">phpMyAdmin</td>
<td class="contact">portal.kryptonite.tech:phpmyadmin_user</td>
<td class="contact"><p style="color:#228B22">Connexion Réussie</p></td></tr>
<tr>
<td class="contact">Informations PHP</td>
<td class="contact">portal.kryptonite.tech:http_user</td>
<td class="contact">/phpinfo.php</td></tr>
<tr>
<td class="contact">Version PHP</td>
<td class="contact">5.6.14</td>
<td class="contact">-</td></tr>
<tr>
<td class="contact">VirtualHost HTML</td>
<td class="contact">portal.kryptonite.tech:vhost_user</td>
<td class="contact">-</td></tr>
<tr>
<td class="contact">Varnish</td>
<td class="contact">portal.kryptonite.tech:varnish_user</td>
<td class="contact">-</td></tr>
<tr>
<td class="contact">Arborescence</td>
<td class="contact">conf.d,html(80,8080)</td>
<td class="contact">-</td></tr>
<tr>
<td class="contact">Connexion SFTP</td>
<td class="contact">portal.kryptonite.tech:7222</td>
<td class="contact">-</td></tr>
<tr>

</table>
</div>
