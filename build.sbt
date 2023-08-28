ThisBuild / version := "0.1.0-SNAPSHOT"

ThisBuild / scalaVersion := "2.13.1"

lazy val root = (project in file("."))
  .settings(
    name := "CatsTemplate"
  )

lazy val http4sVersion = "1.0.0-M40"

libraryDependencies ++= Seq(

  // Cats
  "org.typelevel"       %% "cats-core" % "2.9.0",

  // Cats Effect
  "org.typelevel"       %% "cats-effect" % "3.6-e9aeb8c",

  // FS2
  //  "co.fs2"                  %% "fs2-core"               % "3.7.0",

  // Postgres
  "org.postgresql"      % "postgresql" % "42.6.0",

  // Doobie
  "org.tpolecat"        %% "doobie-core" % "1.0.0-RC4",
  "org.tpolecat"        %% "doobie-postgres" % "1.0.0-RC4",
  "org.tpolecat"        %% "doobie-postgres" % "1.0.0-RC4",

  // Circe
  "io.circe"            %% "circe-parser" % "0.15.0-M1",
  "io.circe"            %% "circe-core" % "0.15.0-M1",

  // http4s
  "org.http4s"          %% "http4s-ember-client" % http4sVersion,
  "org.http4s"          %% "http4s-ember-server" % http4sVersion,
  "org.http4s"          %% "http4s-dsl" % http4sVersion,

  // scache
  //  "com.evolution"           %% "scache"                 % "5.1.2",

  // Testing Frameworks
  "org.scalactic"       %% "scalactic" % "3.2.16" % Test,
  "org.scalatest"       %% "scalatest" % "3.2.16" % Test,
  "com.disneystreaming" %% "weaver-cats" % "0.8.3" % Test
)