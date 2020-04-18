package com.github.andreweggleston;

import discord4j.core.DiscordClient;
import discord4j.core.DiscordClientBuilder;
import discord4j.core.event.domain.lifecycle.ReadyEvent;
import discord4j.core.object.entity.User;

public class Main {

    public static void main(String[] args) {

        final DiscordClient client = new DiscordClientBuilder(System.getenv("BOT_TOKEN")).build();

        client.getEventDispatcher().on(ReadyEvent.class).subscribe(event -> {
            User self = event.getSelf();
            System.out.println(String.format("logged in as %s#%s", self.getUsername(), self.getDiscriminator()));
        });

        client.login().block();
    }
    }

