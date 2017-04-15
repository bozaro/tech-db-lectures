<?php
$db = pg_pconnect("host=localhost port=5432 dbname=docker user=docker password=docker");
$result = pg_query($db, "SELECT title, body FROM news");
while ($row = pg_fetch_row($result)) {
  echo "<h1>$row[0]</h1><p>$row[1]</p>\n";
}
?>