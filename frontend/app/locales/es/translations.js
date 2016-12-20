export default {
  'frontpage' : {
    'action': {
      'index': 'Ver tus tareas',
      'new': 'Crear una tarea'
    },
    'description' : 'Distribuye las tareas de tu colectivo'
  },
  'navbar': {
    'login': 'Entrar',
    'logout': 'Salir',
    'tasks': 'Mis tareas'
  },
  'session': {
    'email': {
      'label': 'Email',
      'placeholder': 'Tu email'
    },
    'link': {
      'password_forgotten': '¿Olvidate tu contraseña?'
    },
    'login': {
      'button': 'Entrar'
    },
    'navigation': {
      'login': 'Entrar',
      'register': 'Registrarse'
    },
    'password': {
      'label': 'Contraseña',
      'placeholder': 'Tu contraseña'
    },
    'password_forgotten': {
      'button': 'Envíame correo de recuperación'
    },
    'register': {
      'button': 'Registrase'
    }
  },
  'tasks' : {
    'attributes' : {
      'description' : 'Descripción',
      'notificationEmail' : 'Correo de notificaciones',
      'notificationSubject' : 'Asunto del correo de notificaciones',
      'recurrence' : 'Repetición',
      'recurrenceMatch' : 'Fórmula de repetición',
      'title' : 'Título'
    },
    'details': {
      'cancel': {
        'button': 'Cancelar'
      },
      'save': {
        'button': 'Guardar'
      }
    },
    'index': {
      'empty': {
        'button': "Crea una tarea",
        'message': "Parece que no participas en ninguna tarea."
      },
      'new': {
        'button': 'Nueva tarea'
      },
      'responsibles': 'Esta semana le toca a {{responsibles}}',
      'timeAhead': 'Toca dentro de X días',
      'title': 'Mis tareas'
    },
    'edit' : {
      'title' : 'Actualizar tarea'
    },
    'new': {
      'title': 'Crear tarea'
    },
    'notifications': {
      'body': 'Mensaje',
      'cancel': {
        'button': 'Cancelar'
      },
      'cc': 'Copia',
      'edit': {
        'button': 'Editar'
      },
      'empty': {
        'button': 'Configura el correo de notificaciones',
        'message': 'Envía un correo a los responsables de cada turno'
      },
      'save': {
        'button': 'Guardar'
      },
      'subject': 'Asunto',
      'to': 'Para'
    },
    'show': {
      'notifications': {
        'title': 'Notificaciones'
      },
      'turns': {
        'title': 'Turnos'
      }
    },
    'turns': {
      'add': {
        'button': 'Añadir turno'
      },
      'addModal': {
        'cancel': 'Cancelar',
        'emails': {
          'label': 'Emails',
          'placeholder': 'Añade emails para enviar notificaciones'
        },
        'name': {
          'label': 'Nombre',
          'placeholder': 'El nombre del grupo'
        },
        'save': '¡Hecho!',
        'title': 'Añade un grupo a este turno'
      },
      'empty': {
        'message': 'Esta tarea no tiene turnos'
      },
      'excludedGroups': {
        'message': 'Sin asignar: {{groups}}'
      },
      'row': {
        'add': {
          'button': 'Añade grupo'
        },
        'cancel': {
          'button': 'Cancelar'
        },
        'edit': {
          'button': 'Editar'
        },
        'save': {
          'button': '¡Hecho!'
        }
      }
    }
  },
  'turns': {
    'weekWithResponsibles': {
      'zero': 'Esta semana: {{ responsibles }}',
      'one': 'La próxima semana: {{ responsibles }}',
      'other': 'En {{count}} semanas: {{ responsibles }}'
    }
  }
};
