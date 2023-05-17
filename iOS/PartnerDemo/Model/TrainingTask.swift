//
//  TrainingTask.swift
//  PartnerDemo
//
//  Created by Pedro Gutiérrez on 16/5/23.
//

import Foundation

/** A set of training tasks (games).
 @remark This is NOT a comprehensive list, please use the API to get the list of keys
 @see https://cognifitapiv2.docs.apiary.io/#reference/0/brain-games/brain-game-list
 */
enum TrainingTask: String, CaseIterable {
    case puzzle3d = "PUZZLE_3D"
    case antEscape = "ANT_ESCAPE"
    case beeBalloon = "BEE_BALLOON"
    case butterflyHunter = "WINDOW_CLEANER"
    case candyFactory = "CANDY_FACTORY"
    case candyLineUp = "CANDY_LINE_UP"
    case colorBee = "CUT_THE_CAKE"
    case colorFrenzy = "COLOR_FRENZY"
    case colorRush = "ECHO_RACE"
    case crossroads = "CROSSROADS"
    case crystalMiner = "ROBOT"
    case cubeFoundry = "BLOCKOUT"
    case digits = "DIGITS"
    case dragsterRacing = "DRAGSTER_RACING"
    case simonSays = "SIMON_SAYS"
    case findThePup = "FIND_THE_PUP"
    case freshqueeze = "FRESHQUEEZE"
    case fuelACar = "FUEL_A_CAR"
    case gemBreaker = "BREAKOUT"
    case gemBreaker3d = "BREAKOUT3D"
    case happyHopper = "SAVE_THE_FROG"
    case jigsaw = "JIGSAW_9"
    case jungleHazard = "MELODY_MAZE"
    case laneChanger = "LANE_SPLITTER"
    case mahjong = "MAHJONG"
    case mahjongUltimate = "MAHJONG_ULTIMATE"
    case mandala = "MANDALA"
    case marbleRace = "MARBLE_RACE"
    case matchIt = "MIX_AND_MATCH"
    case mathMadness = "MATH_MADNESS"
    case mathTwins = "MATH_TWINS"
    case melodicTennis = "AUDIO_TENNIS"
    case melodyMayhem = "MELODY_MAYHEM"
    case minusMalus = "MATH_SUBTRACTION"
    case mouseChallenge = "MOUSE_CHALLENGE"
    case navigate = "NAVIGATE"
    case neonLights = "NEON_LIGHTS"
    case neuronMadness = "SNAKE"
    case numberLines = "MATH_LINES"
    case penguinExplorer = "PENGUIN_MAZE"
    case perfectTension = "STEADY_MOVES"
    case pieceMaking = "PIECE_MAKING"
    case puzzle = "PUZZLE_2D"
    case reactionField = "WHACK_A_MOLE"
    case restaurant = "RESTAURANT"
    case robotFactory = "CRAZY_FACTORY"
    case scrambled = "SCRAMBLED"
    case shapeTheMeaning = "SHAPE_THE_MEANING"
    case shoreDangers = "RIVAL_ORBS"
    case sliceAndDrop = "SLICE_AND_DROP"
    case solitaire = "SOLITAIRE"
    case spaceRescue = "SPACE_RESCUE"
    case starArchitect = "BLOCKBUILDER"
    case sudoku = "SUDOKU_PUZZLE"
    case synaptix = "NEURON_GRAPH"
    case tennisBomb = "TENNIS_BOMB"
    case tennisBowling = "TENNIS_BULLING"
    case tennisTarget = "TENNIS_TARGET"
    case trafficManager = "TRAFFIC_MANAGER"
    case treasureIsland = "PIRATE_ISLAND"
    case twistIt = "TWIST_IT"
    case twistItUltimate = "TWIST_IT_ULTIMATE"
    case visualCrossword = "NAME_ME"
    case waterLilies = "WATER_LILIES"
    case witness = "WITNESS"
    case wordQuest = "WORD_QUEST"
    case wordsBirds = "WORDS_BIRDS"
}

/** Provides a human-readable name for each training session.
 */
func getTrainingTaskName(_ trainingTask: TrainingTask) -> String {
    switch trainingTask {
    case .puzzle3d:
        return "3D Art Puzzle"
    case .antEscape:
        return "Ant Escape"
    case .beeBalloon:
        return "Bee Balloon"
    case .butterflyHunter:
        return "Butterfly Hunter"
    case .candyFactory:
        return "Candy Factory"
    case .candyLineUp:
        return "Candy Line Up"
    case .colorBee:
        return "Color Bee"
    case .colorFrenzy:
        return "Color Frenzy"
    case .colorRush:
        return "Color Rush"
    case .crossroads:
        return "Crossroads"
    case .crystalMiner:
        return "Crystal Miner"
    case .cubeFoundry:
        return "Cube Foundry"
    case .digits:
        return "Digits"
    case .dragsterRacing:
        return "Dragster Racing"
    case .simonSays:
        return "Drive me crazy"
    case .findThePup:
        return "Find Your Pet"
    case .freshqueeze:
        return "Fresh Squeeze"
    case .fuelACar:
        return "Fuel a Car"
    case .gemBreaker:
        return "Gem Breaker"
    case .gemBreaker3d:
        return "Gem Breaker 3D"
    case .happyHopper:
        return "Happy Hopper"
    case .jigsaw:
        return "Jigsaw 9"
    case .jungleHazard:
        return "Jungle Hazard"
    case .laneChanger:
        return "Lane Changer"
    case .mahjong:
        return "Mahjong"
    case .mahjongUltimate:
        return "Mahjong Ultimate"
    case .mandala:
        return "Mandala"
    case .marbleRace:
        return "Marble Race"
    case .matchIt:
        return "Match it!"
    case .mathMadness:
        return "Math Madness"
    case .mathTwins:
        return "Math Twins"
    case .melodicTennis:
        return "Melodic Tennis"
    case .melodyMayhem:
        return "Melody Mayhem"
    case .minusMalus:
        return "Minus Malus"
    case .mouseChallenge:
        return "Mouse Challenge"
    case .navigate:
        return "Navigate"
    case .neonLights:
        return "Neon Lights"
    case .neuronMadness:
        return "Neuron Madness"
    case .numberLines:
        return "Number Lines"
    case .penguinExplorer:
        return "Penguin Explorer"
    case .perfectTension:
        return "Perfect Tension"
    case .pieceMaking:
        return "Piece Making"
    case .puzzle:
        return "Puzzles"
    case .reactionField:
        return "Reaction Field"
    case .restaurant:
        return "Restaurant"
    case .robotFactory:
        return "Robo Factory"
    case .scrambled:
        return "Scrambled"
    case .shapeTheMeaning:
        return "Shape The Meaning"
    case .shoreDangers:
        return "Shore Dangers"
    case .sliceAndDrop:
        return "Slice And Drop"
    case .solitaire:
        return "Solitaire"
    case .spaceRescue:
        return "Space Rescue"
    case .starArchitect:
        return "Star Architect"
    case .sudoku:
        return "Sudoku"
    case .synaptix:
        return "Synaptix"
    case .tennisBomb:
        return "Tennis Bomb"
    case .tennisBowling:
        return "Tennis Bowling"
    case .tennisTarget:
        return "Tennis Target"
    case .trafficManager:
        return "Traffic Manager"
    case .treasureIsland:
        return "PIRATE_ISLAND"
    case .twistIt:
        return "Twist It"
    case .twistItUltimate:
        return "Twist It Ultimate"
    case .visualCrossword:
        return "Visual Crossword"
    case .waterLilies:
        return "Water Lilies"
    case .witness:
        return "Witness"
    case .wordQuest:
        return "Word Quest"
    case .wordsBirds:
        return "Words Birds"
    }
}
