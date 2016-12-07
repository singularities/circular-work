import JSONAPISerializer from 'ember-data/serializers/json-api';
// import DS from 'ember-data';
// import Ember from 'ember';

// const { getOwner } = Ember;

export default JSONAPISerializer.extend({
  // _serializeRelation: function(snapshot, keyName) {
  //   var relationData = snapshot.record[keyName];
  //   if(!relationData) {
  //     return false;
  //   }
  //   var options = relationData._meta.options;
  //   if(options.included === true) {
  //     return true;
  //   }
  //
  //   return false;
  // },
  // _getRelationObjects: function(snapshot, keyName) {
  //   var kind    = snapshot.record[keyName]._meta.kind;
  //   if(kind === 'belongsTo') {
  //     return snapshot.belongsTo(keyName);
  //   } else if (kind === 'hasMany') {
  //     return snapshot.hasMany(keyName);
  //   } else {
  //     // TODO unify exceptions
  //     alert('error');
  //   }
  // },
  serialize(snapshot) {
    let result     = this._super(...arguments);
    let included   = [];
    let serializer = this;

    snapshot.eachRelationship(function(key, relation) {
      let kind = relation.kind;
      let relationSnapshots = snapshot[kind](key);
      relationSnapshots.every(function(object) {
        var serialization = serializer._super(object);
        included.push(serialization.data);
      })
    });
    result.included = included;
  // //     relations      = result.data.relationships;
  // //   var self         = this;
  // //   var includedData;
  // //   if(relations === undefined) {
  // //     includedData = {};
  // //   } else {
  // //     includedData = Object.keys(relations).reduce(function(included, relationKey) {
  // //       var keyName = Ember.String.camelize(relationKey);
  // //
  // //       if(self._serializeRelation(snapshot, keyName)) {
  // //         var relationObjects = self._getRelationObjects(snapshot, keyName);
  // //         if(relationObjects !== undefined) {
  // //           relationObjects.forEach(function(object) {
  // //             var serialization = self._super(object);
  // //             included.push(serialization);
  // //           });
  // //         }
  // //       }
  // //       return included;
  // //     }, []);
  // //   }
  // //
  // //   result.data.included = includedData;
    return result;
  }
});
