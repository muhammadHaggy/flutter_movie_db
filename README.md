# Flutter Movie Database

Movie Database adalah aplikasi yang menampilkan film-film trending dan terkini.

App ini dapat menampilkan film trending dan terkini. Terdapat fitur profile yang menampilkan informasi user seperti nama lengkap, nama panggilan, hobi, dan lain-lain. Informasi ini dapat diedit dan disimpan dalam memori device, termasuk profile photo dengan menyertakan image url pada edit profile page.

App ini menggunakan package json_serializable untuk mempermudah serialization dan deserialization secara otomatis.

App ini menggunakan package json_annotation untuk menggunakan annotation @JsonSerializable pada object class agak diconvert oleh package json_serializable menjadi object yang dapat diserialisasi dengan mudah.

App ini menggunakan sharedpreference untuk menyimpan object user di dalam memory perangkat. object user disimpan dalam bentuk json string.



