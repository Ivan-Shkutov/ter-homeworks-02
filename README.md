## Домашнее задание к занятию «Основы Terraform. Yandex Cloud»

## Шкутов Иван Владимирович


### Задание 0

Ознакомьтесь с документацией к security-groups в Yandex Cloud. Этот функционал понадобится к следующей лекции.

Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!

### Задание 1

В качестве ответа всегда полностью прикладывайте ваш terraform-код в git. Убедитесь что ваша версия Terraform ~>1.8.0

Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.

Создайте сервисный аккаунт и ключ. service_account_key_file.

Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную vms_ssh_public_root_key.

Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.

Подключитесь к консоли ВМ через ssh и выполните команду  curl ifconfig.me. Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: "ssh ubuntu@vm_ip_address". Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: eval $(ssh-agent) && ssh-add Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;

Ответьте, как в процессе обучения могут пригодиться параметры preemptible = true и core_fraction=5 в параметрах ВМ.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;

- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;

- ответы на вопросы.


### Решение:

![9](https://github.com/Ivan-Shkutov/ter-homeworks-02/blob/main/9.png)

1. были добавлены идентификаторы облака и созданной директории

2. создан сервисный аккаунт и ключи доступа

3. сгенерировал ssh-ключи и добавил открытую часть в переменную var_ssh_root_key

4. выполнил terraform init. После этого возникли ошибки, которые были обнаружены в файле main.tf

- platform_id = "standart-v4" заменил на platform_id = "standard-v3"

- cores = 1 заменил на cores = 2

![01](https://github.com/Ivan-Shkutov/ter-homeworks-02/blob/main/01.png)

![3](https://github.com/Ivan-Shkutov/ter-homeworks-02/blob/main/3.png)

5. выполнил подключение по ssh к ВМ и выполнил curl ifconfig.me

![11](https://github.com/Ivan-Shkutov/ter-homeworks-02/blob/main/11.png)

6. preemptible = true - позволяет экономить деньги при аренде ВМ за счет того, что виртуальная машина после 24 часов работы будет остановлена.
  
   core_fraction = 5 - задает максимальную загрузку виртуальных ядер.

### Задание 2

Замените все хардкод-значения для ресурсов yandex_compute_image и yandex_compute_instance на отдельные переменные. К названиям переменных ВМ добавьте в начало префикс vm_web_ . Пример: vm_web_name.

Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их default прежними значениями из main.tf.

Проверьте terraform plan. Изменений быть не должно.


### Решение:

![10](https://github.com/Ivan-Shkutov/ter-homeworks-02/blob/main/10.png)

variables.tf

![14](https://github.com/Ivan-Shkutov/ter-homeworks-02/blob/main/14.png)

main.tf

![15](https://github.com/Ivan-Shkutov/ter-homeworks-02/blob/main/15.png)


### Задание 3

Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.

Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: "netology-develop-platform-db" , cores  = 2, memory = 2, core_fraction = 20. Объявите её переменные с префиксом vm_db_ в том же файле ('vms_platform.tf'). ВМ должна работать в зоне "ru-central1-b"

Примените изменения.

### Решение:

vms_platform.tf

![16](https://github.com/Ivan-Shkutov/ter-homeworks-02/blob/main/16.png)

![12](https://github.com/Ivan-Shkutov/ter-homeworks-02/blob/main/12.png)

![13](https://github.com/Ivan-Shkutov/ter-homeworks-02/blob/main/13.png)


### Задание 4

Объявите в файле outputs.tf один output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)

Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды terraform output.


### Решение:

outputs.tf






### Задание 5

В файле locals.tf опишите в одном local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.

Замените переменные внутри ресурса ВМ на созданные вами local-переменные.

Примените изменения.




### Решение:


### Задание 6

Вместо использования трёх переменных ".._cores",".._memory",".._core_fraction" в блоке resources {...}, объедините их в единую map-переменную vms_resources и внутри неё конфиги обеих ВМ в виде вложенного map(object).

пример из terraform.tfvars:

vms_resources = {
 web={

  cores=2
    memory=2
    core_fraction=5
    hdd_size=10
    hdd_type="network-hdd"
    ...
  },
  db= {
    cores=2
    memory=4
    core_fraction=20
    hdd_size=10
    hdd_type="network-ssd"
    ...
  }
}

Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.

пример из terraform.tfvars:

metadata = {

  serial-port-enable = 1

  ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."

}

Найдите и закоментируйте все, более не используемые переменные проекта.

Проверьте terraform plan. Изменений быть не должно.




### Решение:

