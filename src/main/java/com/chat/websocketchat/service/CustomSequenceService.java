package com.chat.websocketchat.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.FindAndModifyOptions;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import com.chat.websocketchat.model.CustomSequences;

@Service
public class CustomSequenceService {
	@Autowired
	private MongoOperations mongo;

	public long getNextSequence(String className) {
		Query query = new Query();
		query.addCriteria(Criteria.where("_id").is(className));
		CustomSequences counter = mongo.findAndModify(query, new Update().inc("seq", 1),
				new FindAndModifyOptions().returnNew(true).upsert(true), CustomSequences.class);
		return counter.getSeq();
	}
}
