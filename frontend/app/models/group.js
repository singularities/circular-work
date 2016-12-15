import Ember from 'ember';
import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  emails: DS.attr(),
  turns: DS.hasMany('turn'),
  emailsString: Ember.computed('emails.@each', {
    get() {
      return this.get('emails').join("\n");
    },
    set(key, string) {
      var list =
        string.split(/[,\s]/)
        .map(e => e.trim()).
        filter(e => e !== '').
        uniq();

      return this.set('emails', list);
    }
  }),
});
