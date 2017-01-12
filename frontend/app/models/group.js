import Ember from 'ember';
import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  emails: DS.attr(),

  organization: DS.belongsTo('organization'),
  tasks: DS.hasMany('tasks'),

  emailsString: Ember.computed('emails.@each', {
    get() {
      let emails = this.get('emails');

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

      this.set('emails', list);

      return string;
    }
  }),

  hasSameTasksThanOrganization: Ember.computed('organization.tasksWithTurns.length', 'tasks.length', function() {
    return this.get('organization.tasksWithTurns.length') === this.get('tasks.length');
  }),

});
