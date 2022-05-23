# Postgres组件

## 1、Postgres简介

PostgreSQL是一种特性非常齐全的自由软件的对象-关系型数据库管理系统（ORDBMS），是以加州大学计算机系开发的POSTGRES，
4.2版本为基础的对象关系型数据库管理系统。POSTGRES的许多领先概念只是在比较迟的时候才出现在商业网站数据库中。

PostgreSQL支持大部分的SQL标准并且提供了很多其他现代特性，如复杂查询、外键、触发器、视图、事务完整性、多版本并发控制等。

同样，PostgreSQL也可以用许多方法扩展，例如通过增加新的数据类型、函数、操作符、聚集函数、索引方法、过程语言等。

另外，因为许可证的灵活，任何人都可以以任何目的免费使用、修改和分发PostgreSQL。


## 2、Postgres特征

函数：通过函数，可以在数据库服务器端执行指令程序。

索引：用户可以自定义索引方法，或使用内置的 B 树，哈希表与 GiST 索引。

触发器：触发器是由SQL语句查询所触发的事件。如：一个INSERT语句可能触发一个检查数据完整性的触发器。触发器通常由INSERT或UPDATE语句触发。 多版本并发控制：PostgreSQL使用多版本并发控制（MVCC，Multiversion concurrency control）系统进行并发控制，该系统向每个用户提供了一个数据库的"快照"，用户在事务内所作的每个修改，对于其他的用户都不可见，直到该事务成功提交。

规则：规则（RULE）允许一个查询能被重写，通常用来实现对视图（VIEW）的操作，如插入（INSERT）、更新（UPDATE）、删除（DELETE）。

数据类型：包括文本、任意精度的数值数组、JSON 数据、枚举类型、XML 数据等。

全文检索：通过 Tsearch2 或 OpenFTS，8.3版本中内嵌 Tsearch2。

NoSQL：JSON，JSONB，XML，HStore 原生支持，至 NoSQL 数据库的外部数据包装器。

数据仓库：能平滑迁移至同属 PostgreSQL 生态的 GreenPlum，DeepGreen，HAWK 等，使用 FDW 进行 ETL。

