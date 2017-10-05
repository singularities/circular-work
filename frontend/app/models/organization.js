import Ember from 'ember';
import DS from 'ember-data';

const Organization = DS.Model.extend({
  name: DS.attr('string'),
  adminEmails: DS.attr(),

  // Relations
  tasks: DS.hasMany('task'),
  groups: DS.hasMany('groups'),

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
});

export default Organization;
