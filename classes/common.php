<?php
function isValidGuid($guid)
{
    return !empty($guid) && preg_match('/^\{?[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\}?$/', strtoupper($guid));
}
?>