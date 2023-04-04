abstract class Equality<T> {
  const Equality();

  bool equals(T a, T b);

  int hash(T object);
}

class ListEquality<E> implements Equality<List<E>> {
  const ListEquality();

  @override
  bool equals(List<E> a, List<E> b) {
    if (a == b) {
      return true;
    }
    if (a == null || b == null || a.length != b.length) {
      return false;
    }
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }

  @override
  int hash(List<E> list) {
    int hash = 0;
    for (E element in list) {
      hash = _combine(hash, element.hashCode);
    }
    return hash;
  }

  int _combine(int hash, int value) {
    return 0x1fffffff & (hash + value);
  }
}
