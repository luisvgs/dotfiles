function scala-helper() {
    mkdir $@ && cd $_
    git init
    echo '.bsp/
    .idea/
    .metals/
    .bloop/
    .scala-build/
    target/' > .gitignore
    touch .scalafmt.conf
    echo 'version = 3.7.2
    runner.dialect = scala3' > .scalafmt.conf
    mkdir -p src/{main,test}/{scala,resources} project
    touch src/main/scala/Main.scala
    echo '@main def hello: Unit = println("Hello world!")' > src/main/scala/Main.scala
    echo 'sbt.version=1.6.2' > ./project/build.properties
    echo 'name := "NewProject"
    version := "1.9.7"
    scalaVersion := "3.3.1"' > build.sbt
}
