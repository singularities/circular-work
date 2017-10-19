import Ember from 'ember';
import DS from 'ember-data';

const Organization = DS.Model.extend({
  name: DS.attr('string'),
  adminEmails: DS.attr(),

  // Relations
  tasks: DS.hasMany('task'),
  groups: DS.hasMany('groups'),

  session: Ember.inject.service('session'),

  // Computed properties
  tasksWithTurns: Ember.computed.filterBy('tasks', 'hasTurns'),

  adminEmailsString: Ember.computed('adminEmails.@each', {
    get() {
      let emails = this.get('adminEmails');

      if (emails) {
        return emails.join("\n");
      } else {
        return '';
      }
    },
    set(key, string) {
      var list =
        string.split(/[,\s]/)
        .map(e => e.trim()).
        filter(e => e !== '').
        uniq();

      this.set('adminEmails', list);

      return string;
    }
  }),

  isAdmin: Ember.computed('session.isAuthenticated', 'adminEmails', function() {
    return this.get('session.isAuthenticated') &&
      this.get('adminEmails') &&
      this.get('adminEmails').indexOf(this.get('session.data.authenticated.email')) > -1;
  }),
});

export default Organization;
