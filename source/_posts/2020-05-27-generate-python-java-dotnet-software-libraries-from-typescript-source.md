---
layout: post
title: Generate Python, Java, and .NET software libraries from a TypeScript source
comments: true
date: 2020-05-27T22:44:20-04:00
description: "Cross-posted from the AWS Blog post I wrote on the jsii compiler."
keywords:
 - Open Source
 - Developer Tools
 - AWS CDK
 - jsii
 - TypeScript
 - Python
 - Java
 - Dotnet
 - Polyglot
 - Micro-services
categories:
 - technical
tags:
 - AWS Blog
 - Cross-posted
 - Open Source
 - Developer Tools
 - AWS CDK
 - jsii
 - TypeScript
 - Python
 - Java
 - Dotnet
 - Polyglot
 - Micro-services
published: true
---

> Cross-posted from [the AWS Open Source Blog](https://aws.amazon.com/blogs/opensource/generate-python-java-dotnet-software-libraries-from-typescript-source/) article that I authored.

As builders and developers, many of us are aware of the principle of [Don’t Repeat Yourself (or DRY)](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) and practice it every day. Entire runtimes and programming languages have been developed by taking that principle to an even higher level, with the core idea of writing software once and having it run on many different platforms, hardware, and operating systems. In this post, I explore the possibility of authoring and curating a software library in the TypeScript language, which at build time can then be generated into libraries in multiple other programming languages such as Python, Java, and .NET/C#. This is made possible by an open source software framework developed by AWS called [jsii](https://github.com/aws/jsii), one of the core architectural components in the [AWS Cloud Development Kit](https://aws.amazon.com/cdk/) (AWS CDK).

{% img /images/jsii.png 600 'jsii logo' %}

<!-- more -->

AWS CDK is a software development framework to model and provision your cloud application resources in some popular programming languages. Within AWS CDK, jsii enables the authoring and maintenance of “[CDK constructs](https://docs.aws.amazon.com/cdk/latest/guide/constructs.html)” in the TypeScript language, and in turn generates those same constructs for other languages. Jsii creates type-annotated bundles from TypeScript modules and then auto-generates idiomatic libraries (or packages) in a variety of target languages. As detailed in [jsii’s runtime architecture](https://github.com/aws/jsii/blob/master/docs/runtime-architecture.md), the generated types in these target languages proxy the calls to an embedded JavaScript VM, effectively allowing the jsii modules to be “written once and run everywhere.” Due to the performance of the hosted JavaScript engine and the marshaling costs, jsii modules are a good fit for generating development and build toolchains like the AWS CDK, but are not ideal for performance-sensitive applications or use cases.

## Getting started with jsii

[Getting started with jsii](https://github.com/aws/jsii#getting-started) is straightforward—create a new npm package:

```
npm init -y
```

Ensure that [these additional requirements](https://github.com/aws/jsii/blob/master/docs/configuration.md#additional-requirements--extensions) are met for changing it into a jsii module:

```json
{
  // ...
    "main": "lib/index.js",
    "types": "lib/index.d.ts",
    "scripts": {
        "build": "jsii",
        "build:watch": "jsii -w",
        "package": "jsii-pacmak"
    },
    "author": {
        "name": "John Doe"
    },
    "repository": {
        "url": "https://github.com/aws-samples/jsii-code-samples.git"
    }
  // ...
}
```

Install the jsii toolchain as development dependencies into the package `- jsii` and `jsii-pacmak`.

    npm install --development jsii jsii-pacmak

Add [a jsii section](https://github.com/aws/jsii/blob/master/docs/configuration.md#the-jsii-section) into the package.json with the configuration for the generated `dotnet`, `java`, and `python` modules:

```json
{
  // ...
    "jsii": {
        "outdir": "dist",
        "targets": {
            "python": {
                "distName": "aws-jsiisamples.jsii-code-samples",
                "module": "aws_jsiisamples.jsii_code_samples"
            },
            "java": {
                "package": "software.aws.jsiisamples.jsii",
                "maven": {
                    "groupId": "software.aws.jsiisamples.jsii",
                    "artifactId": "jsii-code-samples"
                }
            },
            "dotnet": {
                "namespace": "AWSSamples.Jsii",
                "packageId": "AWSSamples.Jsii"
            }
        }
    }
  // ...
}
```

This should result in a `package.json` similar to [this jsii code sample](https://github.com/aws-samples/jsii-code-samples/blob/master/package.json), which also has continuous integration set up to deploy the jsii modules into package registries such as npm, PyPI, NuGet, and Maven.

##  TypeScript restrictions

To keep the jsii modules compatible with all the supported languages, the jsii compiler restricts the TypeScript language features that can be used on the public API of the jsii modules being authored. This ensures that the proxy types for the public API of the module can then be generated in all of the supported languages. These restrictions and conventions are documented [on GitHub](https://github.com/aws/jsii/blob/master/docs/typescript-restrictions.md) and the compiler generates helpful error messages, along with instructions to resolve any violations.

To summarize, the restrictions over vanilla TypeScript include:

*   Keywords from all the supported languages being enforced as reserved words
*   jsii conventions that view TypeScript interfaces as either:
    *   Behavioral Interfaces—must be prefixed with an uppercase I (similar to `IFoo`), or
    *   Structs—must not have methods and are therefore pure data types.

As [an example](https://github.com/aws-samples/jsii-code-samples/blob/master/lib/index.ts), let’s look at a simple HelloWorld class with two public methods—a greeter and a Fibonacci generator:

```typescript
export class HelloWorld {
    public sayHello(name: string) {
        return `Hello, ${name}`;
    }

    public fibonacci(num: number) {
        let array = [0, 1];
        for (let i = 2; i < num + 1; i++) {
            array.push(array[i - 2] + array[i - 1]);
        }
        return array[num];
    }
}
```

## Performance benchmarks for native vs. jsii modules

The above example library is built and published for JavaScript/TypeScript (at [npm](https://www.npmjs.com/package/jsii-code-samples)), for Python (at [PyPI](https://pypi.org/project/aws-jsiisamples.jsii-code-samples/)), for Java (at [Maven Central](https://search.maven.org/artifact/software.aws.jsiisamples.jsii/jsii-code-samples)) and for .NET/C# (at [NuGet](https://www.nuget.org/packages/AWSSamples.Jsii/)). These were compared against equivalent native implementations in the three generated languages to generate performance benchmarks.

First let’s take a quick look at the native implementations:

### Python

The Python implementation is shown below, can be seen in the [jsii-native-python GitHub repo](https://github.com/aws-samples/jsii-native-python), and is published to [PyPI](https://pypi.org/project/aws-jsiisamples.jsii-native-python/):

```python
class HelloWorld:
    def say_hello(self, name):
        return 'Hello, ' + name

    def fibonacci(self, n):
        table = [0, 1]

        for i in range(2, n + 1):
            table.append(table[i - 2] + table[i - 1])

        return table[n]
```

### Java

The Java implementation is shown below and can be seen in the [jsii-native-java GitHub repo](https://github.com/aws-samples/jsii-native-java), and is published to [Maven Central](https://search.maven.org/artifact/software.aws.jsiisamples.java/jsii-native-java):

```java
import java.util.ArrayList;
import java.util.Arrays;

public class HelloWorld {
    public String sayHello(String name) {
        return "Hello, " + name;
    }

    public int fibonacci(Integer num) {
        ArrayList<Integer> array = new ArrayList<>(Arrays.asList(0, 1));
        for (int i = 2; i < num + 1; i++) {
            array.add(array.get(i - 2) + array.get(i - 1));
        }
        return array.get(num);
    }
}
```

### C#

The C# implementation is as below and can be seen in the [jsii-native-dotnet GitHub repo](https://github.com/aws-samples/jsii-native-dotnet) and is published to [NuGet](https://www.nuget.org/packages/AWSSamples.Jsii.Native/):

```csharp
public class HelloWorld
{
    public string SayHello(string name)
    {
        return $"Hello, {name}";
    }

    public int Fibonacci(int num)
    {
        var array = new List<int> {0, 1};
        for (var i = 2; i < num + 1; i++)
        {
            array.Add(array[i - 2] + array[i - 1]);
        }

        return array[num];
    }
}
```

Now let’s take a look at the benchmarking harnesses themselves, along with the benchmark results:

### [Python benchmarking harness](https://github.com/aws-samples/jsii-python-benchmarking) (using [the built-in timeit module](https://docs.python.org/3.8/library/timeit.html))

|       |jsii module|Native module|
|-------|----------:|------------:|
|Windows|14 ms/loop |117 μs/loop  |
|macOS  |6.7 ms/loop|69.4 μs/loop |

The native Python implementation is two orders of magnitude faster than the jsii implementation.

### [Java benchmarking harness](https://github.com/aws-samples/jsii-java-benchmarking) (using [Java Microbenchmark Harness (JMH)](https://openjdk.java.net/projects/code-tools/jmh/))

|       |jsii module     |Native module|
|-------|---------------:|------------:|
|Windows|12,555.941 μs/op|12.838 μs/op |
|macOS  |8,788.736 μs/op |4.720 μs/op  |

Unsurprisingly, in the case of Java, the native implementation is around three orders of magnitude faster than the jsii one.

### [.NET benchmarking harness](https://github.com/aws-samples/jsii-dotnet-benchmarking) (using [BenchmarkDotNet](https://benchmarkdotnet.org/))

|       |jsii module     |Native module|
|-------|---------------:|------------:|
|Windows|16,034.767 μs/op|4.282 μs/op  |
|macOS  |8,067.421 μs/op |2.917 μs/op  |

And in the case of .NET/C# once again, the native implementation is around three orders of magnitude faster than the jsii one.

## Potential use cases

After recently discovering jsii while looking under the hood within AWS CDK, I was intrigued with the potential this compiler has for non-CDK use cases. Also, I have for a few years been helping to maintain [an open source library](https://github.com/kollavarsham/kollavarsham-js) that converts Gregorian calendar dates into [Malayalam Era calendar](https://en.wikipedia.org/wiki/Malayalam_calendar) (which is one of the sidereal Indian calendar systems). At the time, that was only available as [an npm package](https://www.npmjs.com/package/kollavarsham) for JavaScript/Node.js developers, but there were open requests to get it ported into other languages like [.NET/C#](https://github.com/kollavarsham/kollavarsham.net) and [Python](https://github.com/kollavarsham/kollavarsham-python). In an attempt to understand jsii further, I modified the original ES6 codebase into jsii-compliant TypeScript, which helped to auto-generate the calculation-heavy library into [Python](https://pypi.org/project/kollavarsham/), [Java](https://search.maven.org/artifact/org.kollavarsham.converter/kollavarsham-converter), and [C#](https://www.nuget.org/packages/KollavarshamOrg.Converter).

For any utility libraries like the computation-heavy calendar conversion example above, where the performance overheads shown in the previous section are acceptable, developing them once in jsii-compliant TypeScript and then getting them published for multiple languages can be a good productivity booster, especially today when polyglot microservices constituting a larger distributed application are commonplace.

## Support for more languages

Similar to AWS CDK, the jsii library is developed as an open source library, and the community can and does influence the development of new features. The design goals for the library are documented in the [jsii Design Tenets](https://github.com/aws/jsii/blob/master/docs/specifications/1-introduction.md#design-tenets-unless-you-know-better-ones), and there is [an established process](https://github.com/aws/jsii/blob/master/docs/specifications/5-new-language-intake.md) as well as [a handbook](https://github.com/aws/jsii/blob/master/docs/handbooks/language-implementation.md) for adding support for more languages to be auto-generated from the TypeScript source. With enough demand and contributions from the community, it is not far-fetched to think that other popular languages like Go, Rust, Ruby, etc. will also be supported in the future.

## Conclusion

If you need to build and maintain software libraries in multiple different programming language ecosystems, including TypeScript, and if their performance needs are within what the jsii-generated libraries will provide, get started using [jsii](https://github.com/aws/jsii) on your TypeScript libraries and auto-generate Python, Java, and .NET versions today.
