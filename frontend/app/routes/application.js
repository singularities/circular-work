
// app/routes/application.js
import Ember from 'ember';
import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

export default Ember.Route.extend(ApplicationRouteMixin, {
  i18n: Ember.inject.service(),
  moment: Ember.inject.service(),

  beforeModel() {
    // Globally set ember and moment locales
    this.set('i18n.locale', this.calculateLocale());
    this.get('moment').changeLocale(this.calculateLocale());
  },

  calculateLocale () {
    return navigator.language || navigator.userLanguage || 'en';
  }
});
