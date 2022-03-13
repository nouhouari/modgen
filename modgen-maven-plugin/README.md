# modelgen-maven-plugin

# Getting Started

* Clone source repostiory from `git clone http://psdgit.hin-net.ads/scm/~nhouari/modelgen-maven-plugin.git && cd modelgen-maven-plugin/modelgen-maven-plugin`
* Install in local maven repo `mvn clean install`

# Usage
* Add plugin dependency in your project

```java
<build>
	<plugins>
		<plugin>
			<groupId>com.hin.modelgen.plugin</groupId>
			<artifactId>modelgen-maven-plugin</artifactId>
			<version>0.0.2-SNAPSHOT</version>
			<configuration>
				<outputDirectory>${project.build.directory}/generated-sources/java</outputDirectory>
	            <cqlOutputDir>${project.build.directory}/generated-sources/schema</cqlOutputDir>
	            <htmlOutputDir>${project.build.directory}/generated-sources/html</htmlOutputDir>
				<models>
                  <model>
                    <modelPath>target/modgen-resources/com/hin/pot/traceability/workflow/model/workflow.ecore</modelPath>
                    <rootPackage>com.hin.pot.traceability.workflow</rootPackage>
                    <component>workflow</component>
                  </model>
                  <model>
                    <modelPath>target/modgen-resources/com/hin/pot/traceability/stamporder/model/stamporder.ecore</modelPath>
                    <rootPackage>com.hin.pot.traceability.stamporder</rootPackage>
                    <component>stampOrder</component>
                  </model>
                </models>
			</configuration>
			<executions>
				<execution>
					<phase>generate-sources</phase>
					<goals>
						<goal>gen</goal>
					</goals>
				</execution>
			</executions>
		</plugin>
	</plugins>
</build>

```

### Available Options

1.__projectsOutputDir__ Root output directory. defaultValue = "/output"

2.__projectName__ Project name. defaultValue = "demo"

3.__models__ : List of models to generate. Each model contains:

       * __modelPath__ : Path to the ecore model
       * __rootPackage__ : Name of the root package for the generated code
       * __component__ : Name of t he component
        
4.__apiOutputDir__ : API output source code directory

5.__serviceOutputDir__ : Service output source code directory

6.__bffOutputDir__ : BFF output source code directory

7.__frontendOutputDir__ : Front-End output source code directory

8.__componentOutputDir__ : Component output source code directory

9.__javaOutputSourceDir__ defaultValue = "/src/main/generated"

10.__javaOutputTestDir__ defaultValue = "/src/test/generated"

11.__typeScriptOutputSourceDir__ defaultValue = "/src/app/generated/"
