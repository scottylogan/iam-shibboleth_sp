# configure a Simple Shibboleth SP

class shibboleth_sp (
  $idp = 'idp',
  $contact = "webmaster@$::fqdn",
){

  case $idp {
    'dev': {
      $entity_id = 'https://idp.stanford.edu/'
      $metadata_url = 'https://idp-dev.stanford.edu/metadata.xml'
    }
    'itlab': {
      $entity_id = 'https://idp.itlab.stanford.edu/idp/shibboleth'
      $metadata_url = 'https://idp.itlab.stanford.edu/idp/profile/Metadata/SAML'
    }
    default: {
      $entity_id = 'https://idp.stanford.edu/'
      $metadata_url = 'https://idp.stanford.edu/metadata.xml'
    }
  }

  package { 'libapache2-mod-shib2':
    ensure  => 'latest',
  }

  file { '/etc/shibboleth/shibboleth2.xml':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template('shibboleth_sp/shibboleth2.xml.erb'),
    require => Package['libapache2-mod-shib2'],
  }

  file { '/etc/shibboleth/protocols.xml':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    source  => 'puppet:///modules/shibboleth_sp/protocols.xml',
    require => Package['libapache2-mod-shib2'],
  }

  file { '/etc/shibboleth/attribute-map.xml':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    source  => 'puppet:///modules/shibboleth_sp/attribute-map.xml',
    require => Package['libapache2-mod-shib2'],
  }


}

