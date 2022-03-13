package com.hin.modgen.sample.event.controller;

import java.net.MalformedURLException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.validation.constraints.NotNull;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import io.getstream.client.Client;
import io.getstream.client.FlatFeed;
import io.getstream.core.KeepHistory;
import io.getstream.core.LookupKind;
import io.getstream.core.exceptions.StreamException;
import io.getstream.core.models.Activity;
import io.getstream.core.models.EnrichedActivity;
import io.getstream.core.models.FeedID;
import io.getstream.core.models.FollowRelation;
import io.getstream.core.models.Reaction;
import io.getstream.core.options.EnrichmentFlags;
import io.getstream.core.options.Filter;
import io.getstream.core.options.Limit;
import lombok.extern.slf4j.Slf4j;



/**
 * Base source
 * https://github.com/GetStream/stream-java/blob/main/example/Example.java
 * @author nourreddine
 *
 */
@RestController
@RequestMapping("feed")
@Slf4j
public class FeedController {

	private Client client;

	@PostConstruct
	private void init() {
		try {
			client = Client.builder("dn6vjv2esxeh", "hp25few8wk45q5sj6y9nektu6agbv7589zage329963rqhm7wf3ymtjdkrjm7ska")
					.build();
			log.info("Stream client initialized successfully!");
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
	}

	@GetMapping("post")
	public void postActity(@RequestParam @NotNull String user, @RequestParam @NotNull String post,
			@RequestParam @NotNull String feed) {
		log.info("User {} is posting {}", user, post);
		FlatFeed flatFeed = client.flatFeed(new FeedID(feed, user));
		try {
			flatFeed.addActivities(
					Activity.builder().actor(user).verb("add").object(post).foreignID("picture:123").build());
		} catch (StreamException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@GetMapping("follow")
	public void follow(@RequestParam @NotNull String followee, @RequestParam @NotNull String follower,
			@RequestParam @NotNull String feed) {
		log.info("User user {} is following {}", follower, followee);
		FlatFeed followerFeed = client.flatFeed(new FeedID(feed, follower));
		FlatFeed followeeFeed = client.flatFeed("user", followee);
		try {
			followerFeed.follow(followeeFeed);
		} catch (StreamException e) {
			e.printStackTrace();
		}
	}

	@GetMapping("unfollow")
	public void unfollow(@RequestParam @NotNull String followee, @RequestParam @NotNull String follower,
			@RequestParam @NotNull String feed) {
		log.info("User user {} is following {}", follower, followee);
		FlatFeed followerFeed = client.flatFeed(new FeedID(feed, follower));
		FlatFeed followeeFeed = client.flatFeed("user", followee);
		try {
			followerFeed.unfollow(followeeFeed, KeepHistory.NO); // We can keep the history as well
		} catch (StreamException e) {
			e.printStackTrace();
		}
	}

	@GetMapping("followers")
	public List<FollowRelation> getFollowers(@RequestParam @NotNull String user) {
		FlatFeed userFeed = client.flatFeed("user", user);
		try {
			return userFeed.getFollowers(new Limit(10)).join();
		} catch (StreamException e) {
			e.printStackTrace();
		}
		return null;
	}

	@GetMapping("activity")
	public List<EnrichedActivity> getTimeLineFeed(@RequestParam @NotNull String user,
			@RequestParam @NotNull String feed) {
		FlatFeed followerFeed = client.flatFeed(new FeedID(feed, user));
		try {
			return followerFeed.getEnrichedActivities(
					new EnrichmentFlags().withOwnReactions().withRecentReactions().withReactionCounts()).join();
		} catch (StreamException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	@DeleteMapping("activity")
	public void removeActivity( @RequestParam @NotNull String user, @RequestParam @NotNull String activityId) {
		FlatFeed userFeed = client.flatFeed("user", user);
		try {
			userFeed.removeActivityByForeignID(activityId);
		} catch (StreamException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@GetMapping("like")
	public Reaction like(@RequestParam @NotNull String activityId, @RequestParam @NotNull String user) {
		Reaction like = new Reaction.Builder().kind("like").activityID(activityId).build();
		try {
			like = client.reactions().add(user, like).join();
			return like;
		} catch (StreamException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@GetMapping("unlike")
	public void unlike(@RequestParam @NotNull String likeId) {
		try {
			client.reactions().delete(likeId);
		} catch (StreamException e) {
			e.printStackTrace();
		}
	}

	@GetMapping("comment")
	public Reaction comment(@RequestParam @NotNull String activityId, @RequestParam @NotNull String user,
			@RequestParam @NotNull String com) {
		Reaction comment = new Reaction.Builder().kind("comment").activityID(activityId).extraField("text", com)
				.build();
		try {
			comment = client.reactions().add(user, comment).join();
			return comment;
		} catch (StreamException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@GetMapping("reactions")
	public List<Reaction> reactions(@RequestParam @NotNull String activityId) {
		try {
			return client.reactions().filter(LookupKind.ACTIVITY, activityId).join();
			
			// Filter the reaction based on their type
//			return client.reactions().filter(LookupKind.ACTIVITY, activityId, new Limit(10), "like")
//            .join();
		} catch (StreamException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
