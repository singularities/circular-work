import Ember from 'ember';

export default Ember.Mixin.create({
  organizationToken: Ember.inject.service(),

  ajaxOptions() {
    let hash = this._super(...arguments);

    let token = this.get('organizationToken.token');

    if (token) {
      hash.data.token = token;
    }

    return hash;
  },
});
