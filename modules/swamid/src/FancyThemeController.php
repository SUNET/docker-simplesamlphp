<?php

namespace SimpleSAML\Module\swamid;

use Twig\Environment;
use SimpleSAML\XHTML\TemplateControllerInterface;
use SimpleSAML\{Configuration, Error, Logger, Module, Session, Utils};

class FancyThemeController implements TemplateControllerInterface
{
    /**
     * Modify the twig environment after its initialization (e.g. add filters or extensions).
     *
     * @param \Twig\Environment $twig The current twig environment.
     * @return void
     */
    public function setUpTwig(Environment &$twig): void
    {
    }

    /**
     * Add, delete or modify the data passed to the template.
     *
     * This method will be called right before displaying the template.
     *
     * @param array $data The current data used by the template.
     * @return void
     */
    public function display(array &$data): void
    {
	$config = Configuration::getConfig('authsources.php');
	$sources = $config->getOptions();
	$users = [];
	foreach ($sources as $id) {
	    if ($id != "example-userpass") {
	        next;
	    }
            $source = $config->getArray($id);
	    // We don't want the name of the source
	    unset($source[0]);

	    foreach ($source as $key => $user) {
		    $keyArray = explode(":", $key);
		    $users[] = $keyArray[0];
	    }
    }

	$data['users'] = $users;
    }
}
