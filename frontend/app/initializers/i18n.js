export default {
  name: 'i18n',
  after: 'ember-i18n',
  initialize: function(app) {
    [
      'component',
      'controller',
      'model',
      'route',
      'view'
    ].forEach(type => {
      app.inject(type, 'i18n', 'service:i18n');
    });
  }
};
