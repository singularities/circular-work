export default {
  'frontpage' : {
    'action': {
      'index': 'View your tasks',
      'new': 'Create new task'
    },
    'description' : 'Your community tasks,<br/>distributed.'
  },
  'navbar': {
    'login': 'Login',
    'logout': 'Logout',
    'tasks': 'My tasks'
  },
  'session': {
    'email': {
      'label': 'Email',
      'placeholder': 'Your email'
    },
    'link': {
      'password_forgotten': 'Forgot your password?'
    },
    'login': {
      'button': 'Login'
    },
    'navigation': {
      'login': 'Login',
      'register': 'Register'
    },
    'password': {
      'label': 'Password',
      'placeholder': 'Your password'
    },
    'password_forgotten': {
      'button': 'Send me recovery email'
    },
    'register': {
      'button': 'Register'
    }
  },
  'tasks' : {
    'attributes' : {
      'description' : 'Description',
      'notificationEmail' : 'Email for notification',
      'notificationSubject' : 'Subject for the notification email',
      'recurrence' : 'Recurrence',
      'recurrenceMatch' : 'Recurrence formula',
      'title' : 'Title'
    },
    'details': {
      'cancel': {
        'button': 'Cancel'
      },
      'save': {
        'button': 'Save'
      }
    },
    'index': {
      'empty': {
        'button': "Create a new task",
        'message': "It seems that you are not participating in any task."
      },
      'new': {
        'button': 'New task'
      },
      'responsibles': 'This week falls on {{responsibles}}',
      'title': 'My tasks'
    },
    'edit' : {
      'title' : 'Update task'
    },
    'new': {
      'title': 'Create task'
    },
    'notifications': {
      'body': 'Message',
      'cancel': {
        'button': 'Cancel'
      },
      'cc': 'CC:',
      'edit': {
        'button': 'Edit'
      },
      'empty': {
        'button': 'Set up notification email',
        'message': 'Send an email to notify responsibles on their turn'
      },
      'save': {
        'button': 'Save'
      },
      'subject': 'Subject',
      'to': 'To:'
    },
    'show': {
      'notifications': {
        'title': 'Notifications'
      },
      'turns': {
        'title': 'Turns'
      }
    },
    'turns': {
      'add': {
        'button': "Add turn"
      },
      'empty': {
        'message': 'This task has no turns'
      },
      'row': {
        'edit': {
          'button': 'Edit'
        }
      }
    }
  },
  'turns': {
    'weekWithResponsibles': {
      'zero': 'This week: {{ responsibles }}',
      'one': 'The next week: {{ responsibles }}',
      'other': 'In {{count}} weeks: {{ responsibles }}'
    }
  }
};
