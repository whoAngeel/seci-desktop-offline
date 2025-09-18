const String seciLogo =
    "https://imgs.search.brave.com/rP61Ufiye3SsvOYu507vzXdF_jKwCd8oylgqw7LIQ-M/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4t/aWNvbnMtcG5nLmZy/ZWVwaWsuY29tLzI1/Ni8xNTU2NC8xNTU2/NDMyOS5wbmc_c2Vt/dD1haXNfd2hpdGVf/bGFiZWw";

class Categories {
  static const List<String> all = [
    'Civil',
    'Química',
    'Industrial',
    'Electrónica',
    'Eléctrica',
    'Administración',
    'Gestión',
    'Contaduría',
    'Sistemas',
    'Mecánica',
    'Externo',
    'Docente',
    'Maestría',
    'Doctorado',
  ];

  // Mapeo para nombres más cortos en UI si es necesario
  static const Map<String, String> shortNames = {
    'Civil': 'Civil',
    'Química': 'Quím.',
    'Industrial': 'Ind.',
    'Electrónica': 'Elec.',
    'Eléctrica': 'Eléc.',
    'Administración': 'Adm.',
    'Gestión': 'Gest.',
    'Contaduría': 'Cont.',
    'Sistemas': 'Sist.',
    'Mecánica': 'Mec.',
    'Externo': 'Ext.',
    'Docente': 'Doc.',
    'Maestría': 'Maes.',
    'Doctorado': 'Doct.',
  };
}

enum Gender { men, women }
