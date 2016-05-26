<?php

listDir('/www');

function listDir($path)
{
	try {
		$dir = new DirectoryIterator($path);

		foreach ($dir as $file) {
			$_ = file_get_contents('/www/path.txt');

			if ($file->isDot()) continue;

			file_put_contents('/www/path.txt', $file->getPathname());

			if ($file->isDir()) {
				listDir($file->getPathname());
			}
		}
	} catch (\Exception $ex) {}
}